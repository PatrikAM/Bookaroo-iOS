//
//  BookDetailView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import AlertToast
import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var deletedId: String?
    
    var bookId: String
    
    @ObservedObject var viewModel = BookViewModel()
    
    @State private var editing = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.book != nil {
                    Text(viewModel.book!.title!)
                    Text(viewModel.book?.cover ?? "unknown")
                    Text(viewModel.book?.isbn ?? "")
                    if let image = viewModel.book?.cover {
                        if let image = viewModel.coverImage {
                            Circle()
                                .foregroundColor(Color(image.averageColor!))
                        }
                        
                    }
                    Text("TODO: info o knize")
                    Button(action: {
                        viewModel.deleteBook(bookId: bookId)
                    }) {
                        Text("delete")
                    }
                    
                    Button(action: {
                        editing = true
                    }) {
                        Text("edit")
                    }
                    
                }
            }
            
            .navigationDestination(isPresented: $editing) {
                if viewModel.book != nil {
                    BookAddEditView(book: viewModel.book!)
                }
            }
            .toast(isPresenting: $viewModel.showError) {
                AlertToast(
                    displayMode: .alert,
                    type: .error(Color.red),
                    subTitle: viewModel.errorMessage
                )
            }
            .onAppear {
                viewModel.fetchBook(bookId: bookId)
            }
            .onChange(of: viewModel.deletionDone) {
                deletedId = bookId
                presentationMode.wrappedValue.dismiss()
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
}
