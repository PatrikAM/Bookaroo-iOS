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

    
    var body: some View {
        VStack {
            if booksViewModel.isLoading {
                ProgressView()
            } else if booksViewModel.books != nil {
                if librariesViewModel.libraries != nil {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(librariesViewModel.libraries!) { library in
//                                Text(library.name!)
                                Chip(titleKey: library.name!, isSelected: library.isSelected!)
                            }
                        }
                    }
                }
                List {
                    ForEach(booksViewModel.books!) { book in
                        Text(book.title!)
                    }
                }
            } else {
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
//        .navigate(to: BaseView(), when: $isLoggedOut)
    }
    
}

