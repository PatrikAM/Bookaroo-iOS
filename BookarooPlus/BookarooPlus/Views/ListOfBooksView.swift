//
//  ListOfBooksView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 05.01.2024.
//

import SwiftUI

struct ListOfBooksView: View {
    
    @ObservedObject var viewModel = ListOfBooksViewModel()
    @ObservedObject var authManager: AuthManager = .init()
//    @Environment(\.presentationMode) var presentationMode
    @Binding var isLoggedOut: Bool

    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.books != nil {
                List {
                    ForEach(viewModel.books!) { book in
                        Text(book.title!)
                    }
                }
            } else {
                Text(viewModel.errorMessage!)
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
            viewModel.fetchBooks()
        }
//        .navigate(to: BaseView(), when: $isLoggedOut)
    }
    
}

