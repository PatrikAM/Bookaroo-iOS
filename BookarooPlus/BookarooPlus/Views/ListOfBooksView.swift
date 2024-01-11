//
//  ListOfBooksView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 05.01.2024.
//

import SwiftUI

struct ListOfBooksView: View {
    
    @ObservedObject var booksViewModel = ListOfBooksViewModel()
    @ObservedObject var librariesViewModel = ListOfLibrariesViewModel()
    @ObservedObject var authManager: AuthManager = .init()
    //    @Environment(\.presentationMode) var presentationMode
    @Binding var isLoggedOut: Bool
    
    @State var selectionChange = false
    
    
    var body: some View {
        NavigationStack {
            if booksViewModel.isLoading {
                ProgressView()
            } else if booksViewModel.books != nil {
                if librariesViewModel.libraries != nil {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(librariesViewModel.libraries!.indices) { index in
                                //                                Text(library.name!)
                                Chip(
                                    titleKey: librariesViewModel.libraries![index].name!,
                                    isSelected: librariesViewModel.libraries![index].isSelected!,
                                    selectionChanges: $selectionChange
                                ) {
                                    librariesViewModel.libraries![index].isSelected?.toggle()
                                }
                            }
                        }
                        
                    }
                }
                List {
                    //                    ForEach(booksViewModel.books!) { book in
                    //                        Text(book.title!)
                    //                    }
                    ForEach(booksViewModel.filteredBooks!) { book in
                        NavigationLink {
                            BookDetailView(bookId: book.id!)
                                .toolbar(.hidden, for: .tabBar)
                        } label: {
                            Text(book.title!)
                        }
                    }
                }
            }
            else {
                Text(booksViewModel.errorMessage!)
            }
            Button(action: {
                authManager.logout()
                isLoggedOut = true
                //                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Log out")
            })
        }
        .onAppear {
            booksViewModel.fetchBooks()
            librariesViewModel.fetchLibraries()
        }
        .onChange(of: selectionChange) {
            if librariesViewModel.libraries!.filter({ $0.isSelected! }).isEmpty {
                booksViewModel.filteredBooks = booksViewModel.books
            } else {
                booksViewModel.filterBooks(libs: librariesViewModel.libraries!.filter { $0.isSelected! })
            }
        }
        //        .navigate(to: BaseView(), when: $isLoggedOut)
    }
}



