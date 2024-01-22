//
//  UserOptionsView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 11.01.2024.
//

import SwiftUI

struct UserOptionsView: View {
    
    @ObservedObject var authManager: AuthManager = .init()
    @Binding var isLoggedOut: Bool
    
    private let defaults = UserDefaults.standard
    
    @State var recommenderOutput: [String]? = nil
    @State var recommendedBookName: String? = nil
    @State var recommendedBook: Book? = nil
    @State var deleteId: String? = nil
    
    @State var showRecommendation: Bool = false
    
    @ObservedObject var libsViewModel = ListOfLibrariesViewModel()
    @ObservedObject var booksViewModel = ListOfBooksViewModel()
    
    let model: BooksRecommender = .init()
    
    var body: some View {
        VStack(alignment: .leading){
            if (booksViewModel.isLoading || libsViewModel.isLoading) {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if(booksViewModel.errorMessage != nil || libsViewModel.errorMessage != nil) {
                VStack {
                    // TODO: view localized alternative texts based on error message response
                    if (booksViewModel.errorMessage != nil) {
                        Text(booksViewModel.errorMessage!)
                    } else if (libsViewModel.errorMessage != nil) {
                        Text(libsViewModel.errorMessage!)
                    } else {
                        Text("An unknown error has occurred.")
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Image(AssetsConstants.accessDeniedIcon.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 270)
                }
            }
            else {
                VStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Spacer()
                            .frame(width: 60)
                        VStack {
                            if let name = defaults.string(forKey: DefaultsKey.name.rawValue) {
                                Text(name.capitalizeEachWord())
                                    .font(.headline)
                            } else {
                                Text("User".capitalizeEachWord())
                                    .font(.headline)
                            }
                            
                            Text(defaults.string(forKey: DefaultsKey.login.rawValue)!)
                        }
                        Spacer()
                    }
                    .padding(.all)
                    
                    Divider()
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        if let libCount = libsViewModel.libraries?.count {
                            Text("Libraries: \(libCount)")
                        } else {
                            Text("Libraries: none")
                        }
                        Divider()
                            .frame(height: 25)
                        Text(LocalizedStringKey("Books: \(booksViewModel.books?.count ?? 0)"))
                        
                    }
                    
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    if let relativeBookRead = booksViewModel.relativeBookRead {
                        VStack {
                            Text("Books read from all libraries:")
                                .font(.headline)
                            Spacer()
                                .frame(height: 20)
                            ProgressView(value: relativeBookRead,
                                         label:
                                            {
                                if (relativeBookRead < 0.3) {
                                    Text("You should probably read a little more.")
                                } else if (0.3 <= relativeBookRead && relativeBookRead < 0.6) {
                                    Text("You're doing great. You could do greater, though.")
                                } else if (0.6 <= relativeBookRead && relativeBookRead < 0.9) {
                                    Text("That's pretty good!")
                                } else if (0.9 <= relativeBookRead && relativeBookRead < 1.0) {
                                    Text("Almost there!")
                                } else {
                                    Text("You read me like a book.")
                                }
                                
                            },
                                         currentValueLabel: { Text("\(relativeBookRead*100, specifier: "%.2f") %") })
                            .progressViewStyle(ProgressBarStyle(height: 30.0))
                            .frame(height: 60)
                        }
                        .padding(.all)
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Button(action: {

                        var bookDict = Dictionary<String, Double>()
                        
                        booksViewModel.books?.forEach { book in
                            bookDict[book.title!] = book.favourite ?? false ? 1.0 : 0.0
                        }

                        let recommenderOutput = try? model.prediction(
                            input: BooksRecommenderInput(items: bookDict, k: 10, restrict_: [], exclude: [])
                        )
                        
                        if recommenderOutput == nil {
                            fatalError("Unexpected runtime error.")
                        } else {
                            var list: [String] = []
                            
                            for str in recommenderOutput!.recommendations{
                                let score = recommenderOutput?.scores[str] ?? 0
                                let filtered = booksViewModel.books?.filter { book in
                                    book.title == str && score != 0 && !book.read!
                                }
                                if filtered != nil && !filtered!.isEmpty {
                                    list.append(str)
                                    print(str)
                                }
                            }
                            
                            self.recommenderOutput = list
                            
                            self.recommendedBook = booksViewModel.books?.first { book in
                                book.title == list.first
                            }

                            self.recommendedBookName = list.first
                            self.showRecommendation.toggle()
                        }

                    }, label: {
                        Text("Recommend me a book")
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Button(action: {
                        authManager.logout()
                        isLoggedOut = true
                        //                presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Log out")
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showRecommendation) {
            if recommendedBook != nil && recommendedBook?.id != nil {
                BookDetailView(deletedId: $deleteId, bookId: recommendedBook!.id!)
            } else {
                Text("Book recommendation for today")
                Text(recommendedBookName ?? "none")
            }
        }
        .onAppear{
            libsViewModel.fetchLibraries()
            booksViewModel.fetchBooks()
        }
    }
}
