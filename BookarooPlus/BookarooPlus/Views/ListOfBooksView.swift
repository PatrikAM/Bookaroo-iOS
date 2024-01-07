//
//  ListOfBooksView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 05.01.2024.
//

import SwiftUI

struct ListOfBooksView: View {
    
    @ObservedObject var viewModel = ListOfBooksViewModel()
    
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
        }
        .onAppear {
            viewModel.fetchBooks()
        }
        
    }
    
}

