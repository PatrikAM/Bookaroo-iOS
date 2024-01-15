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
    @State private var selectedBook: String?
    
    
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
                                .padding(.trailing, 10)
                            }
                        }
                        .padding(10)
                        
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        //                    BookListCard(book: booksViewModel.filteredBooks!.first!)
                        ForEach(booksViewModel.filteredBooks!, id: \.id) { book in
                            BookListCard(book: book)
                                .onTapGesture {
                                    selectedBook = book.id!
                                }
                                .padding(.all)
                                .ignoresSafeArea(edges: .horizontal)
                        }
                    }
                    .scrollTargetLayout()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal)
                
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
        .navigationDestination(item: $selectedBook) { bookId in
            BookDetailView(bookId: bookId)
        }
        //        .navigate(to: BaseView(), when: $isLoggedOut)
    }
}



