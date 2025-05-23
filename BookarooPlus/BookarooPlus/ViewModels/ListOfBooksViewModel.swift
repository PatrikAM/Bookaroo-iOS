//
//  ListOfBooksViewModel.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 06.01.2024.
//

import Foundation

class ListOfBooksViewModel: ObservableObject {
    
    private let api = BooksApiManager()
    
    @Published var books: [Book]? = nil
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    
    @Published var filteredBooks: [Book]? = nil
    
    @Published var changes: Bool = false
    @Published var relativeBookRead: Float? = nil
    
    
    func fetchBooks() {
        isLoading = true
        errorMessage = nil
        Task {
            guard let result: CommunicationResult<[Book]>? = await api.fetchBooks() else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        self.books = data
                        self.filteredBooks = self.books
                        if let booksRead = self.books?.filter { book in book.read! }.count {
                            self.relativeBookRead = Float(booksRead) / Float(self.books!.count)
                        }
                        self.isLoading = false
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = APIErrorsConstants.loginFailed.rawValue
                        case .badUrl:
                            self.errorMessage = APIErrorsConstants.badUrl.rawValue
                        case .invalidRequest:
                            self.errorMessage = APIErrorsConstants.invalidRequest.rawValue
                        case .badStatus:
                            self.errorMessage = APIErrorsConstants.badStatusCode.rawValue
                        case .failedToDecodeResponse:
                            self.errorMessage = APIErrorsConstants.failedToDecodeResponse.rawValue
                        case .unknownError:
                            self.errorMessage = APIErrorsConstants.unknownError.rawValue
                        }
                        self.isLoading = false
                        return
                    case .none:
                        self.errorMessage = "unknonw error"
                        print("total failure")
                        self.isLoading = false
                        return
                    }
                    self.isLoading = false
                    
                }
            }
        }
    }
    
    func filterBooks(libs: [Library]) {
        let listOfIDs = libs.map { $0.id }
        var prep = self.books
        filteredBooks = prep!.filter({ book in listOfIDs.contains(book.library!) })
    }
    
    private func getBookByIdFromList(bookId: String) -> Book {
        return self.books!.first(where: { book in book.id == bookId } )!
    }
    
    
    func toggleFavourite(bookId: String) {
        
        var book: Book? = nil
        self.books?.indices.forEach { index in
            if (self.books![index].id == bookId) {
                self.books![index].favourite?.toggle()
                book = self.books![index]
            }
        }
        //        var book = getBookByIdFromList(bookId: bookId)
        //        if (book.favourite == nil) {
        //            book.favourite = false
        //        } else {
        //            book.favourite!.toggle()
        //        }
        updateBook(book: book!)
    }
    
    func toggleRead(bookId: String) {
        
        var book: Book? = nil
        self.books?.indices.forEach { index in
            if (self.books![index].id == bookId) {
                self.books![index].read?.toggle()
                book = self.books![index]
            }
        }
        //        var book = getBookByIdFromList(bookId: bookId)
        //        if (book.read == nil) {
        //            book.read = false
        //        } else {
        //            book.read!.toggle()
        //        }
        updateBook(book: book!)
    }
    
    func updateBook(book: Book) {
        //        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            guard let result: CommunicationResult<Book>? = await self.api.updateBook(book: book) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        self.books?.indices.forEach { index in

                            if (self.books![index].id == book.id) {
                                self.books![index] = data
                            }
                        }
                        self.filteredBooks?.indices.forEach { index in
                            if (self.filteredBooks![index].id == book.id) {
                                self.filteredBooks![index] = data
                            }
                        }
                        isLoading = false
                    case .failure:
                        self.errorMessage = "failed to update"
                        //
                    case .none:
                        self.errorMessage = "unknonw error"
                    }
                }
            }
        }
    }
    
}
