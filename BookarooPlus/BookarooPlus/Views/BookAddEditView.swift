//
//  BookAddEditView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Combine
import SwiftUI
import AlertToast

struct BookAddEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isbn: String? = nil
    
    //    let id: String? = nil
    @State var book: Book = Book()
    @State var pages: String = ""
    
//    @State var selectedLibrary: Library? = nil
    @State var selectedLibrary: Library = Library(id: "createThisOne", name: "Default")
    
    @ObservedObject var viewModel = BookViewModel()
    @ObservedObject var libsViewModel = ListOfLibrariesViewModel()
    
    var body: some View {
        VStack {
            BookarooTextfield(
                label: "Title",
                value: $book.title.toUnwrapped(defaultValue: "")
            )
            
            BookarooTextfield(
                label: "Author",
                value: $book.author.toUnwrapped(defaultValue: "")
            )
            
            BookarooTextfield(
                label: "ISBN",
                value: $book.isbn.toUnwrapped(defaultValue: "")
            )
            
            Picker("Select a paint color", selection: $selectedLibrary) {
                if libsViewModel.libraries != nil {
                    ForEach(libsViewModel.libraries!, id: \.self) {
                        if let name = $0.name {
                            Text($0.name!)
                        }
                    }
                }
            }
            .pickerStyle(.menu)
            .textFieldStyle(ElegantTextFieldStyle())
            
            BookarooTextfield(
                label: "Cover URL",
                value: $book.cover.toUnwrapped(defaultValue: "")
            )
            
            BookarooTextfield(
                label: "Publisher",
                value: $book.publisher.toUnwrapped(defaultValue: "")
            )
            
            BookarooTextfield(
                label: "Published",
                value: $book.published.toUnwrapped(defaultValue: "")
            )
            .keyboardType(.numberPad)
            
            BookarooTextfield(
                label: "Pages",
                value: $pages
            )
            .keyboardType(.numberPad)
            
            Button(action: {
                if selectedLibrary.id == "createThisOne" {
                    // TODO: create Library
                } else {
                    book.pages = Int(pages)
                    viewModel.saveBook(book: book)
                }
            }) {
                Text("Save")
            }
            
        }
        .onAppear {
            libsViewModel.fetchLibraries()
            
            if isbn != nil {
                viewModel.fetchBookByIsbn(isbn: isbn!)
            }
            
            if (book.id == nil) {
                book.isbn = isbn
                viewModel.isUpdating = false
            }
            if let pgs = book.pages {
                pages = "\(pgs)"
            }
            viewModel.book = book
        }
        .onChange(of: selectedLibrary) {
            self.book.library = selectedLibrary.id
        }
        .onChange(of: libsViewModel.libraries) {
            if viewModel.isUpdating {
                selectedLibrary = (libsViewModel.libraries?.filter {
                    lib in lib.id == book.library
                }.first)!
            } else {
                if libsViewModel.libraries!.isEmpty {
                    selectedLibrary = libsViewModel.libraries!.first!
                }
            }
        }
        .onChange(of: viewModel.book) {
            viewModel.book!.isbn = isbn
            book = viewModel.book!
            if let pgs = viewModel.book!.pages {
                pages = "\(pgs)"
            }
        }
        .onChange(of: viewModel.isLoading) {
            if !viewModel.isLoading {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .toast(isPresenting: $viewModel.showError) {
            AlertToast(
                displayMode: .alert,
                type: .error(Color.red),
                subTitle: viewModel.errorMessage
            )
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
