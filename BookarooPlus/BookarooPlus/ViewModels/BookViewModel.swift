//
//  BookViewModel.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 10.01.2024.
//

import Foundation
import UIKit

class BookViewModel: ObservableObject {
    
    @Published var book: Book? = nil
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    @Published var coverImage: UIImage? = nil
    @Published var coverImageFetchingDone: Bool = false
    
    @Published var deletionDone = false
    
    @Published var isUpdating = true
    
    @Published var libraries: [Library] = []
    
    private let api = BooksApiManager()
    private let gapi = GBooksApiManager()
    
    
    func fetchBook(bookId: String) {
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            guard let result: CommunicationResult<Book>? = await api.fetchBook(bookId: bookId) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        self.book = data
                        self.isLoading = false
                        if let cover = book?.cover {
                            Task {
                                guard let result: CommunicationResult<UIImage>? = await api.downloadCover(fromUrl: cover) else {
                                    print("failed")
                                    return
                                }
                                Task {
                                    await MainActor.run {
                                        switch(result) {
                                        case .success(let data):
                                            print("succeded")
                                            self.coverImage = data
                                            self.coverImageFetchingDone = true
                                        case .failure(_):
                                            self.coverImageFetchingDone = true
                                        case .none:
                                            self.coverImageFetchingDone = true
                                        }
                                    }
                                }
                            }
                        }
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
                    case .none:
                        self.errorMessage = APIErrorsConstants.unknownError.rawValue
                    }
                    self.showError = self.errorMessage != nil
                    self.isLoading = false
                }
            }
        }
    }
    
    func deleteBook(bookId: String) {
//        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            guard let result: CommunicationResult<Book>? = await api.deleteBook(bookId: bookId) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        self.book = data
                        self.deletionDone = true
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = "Failed to delete"
                        case .badUrl:
                            self.errorMessage = "Failed to access the server"
                        case .invalidRequest:
                            self.errorMessage = "Failed to delete"
                        case .badStatus:
                            self.errorMessage = "Failed to delete"
                        case .failedToDecodeResponse:
                            self.errorMessage = "Failed to decode (may be deleted]"
                        case .unknownError:
                            self.errorMessage = "unknown error"
                        }
                    case .none:
                        self.errorMessage = "unknonw error"
                    }
                    self.showError = self.errorMessage != nil
//                    self.isLoading = false
                }
            }
        }
    }
    
    func saveBook(book: Book) {
        
        if book.title == nil || ((book.title?.isEmpty) != false) ||
            book.author == nil || ((book.author?.isEmpty) != false) ||
            book.isbn == nil || ((book.isbn?.isEmpty) != false) ||
            book.library == nil || ((book.library?.isEmpty) != false)
        
        {
            errorMessage = "Please fill all required fields"
            showError = true
            return
        }
        
        if isUpdating {
            updateBook(book: book)
        } else {
            self.isLoading = true
            self.errorMessage = nil
            
            Task {
                guard let result: CommunicationResult<Book>? = await api.createBook(book: book) else {return}
                Task {
                    await MainActor.run {
                        switch(result) {
                        case .success(let data):
//                            self.book = data
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
                        case .none:
                            self.errorMessage = APIErrorsConstants.unknownError.rawValue
                        }
                        self.showError = self.errorMessage != nil
//                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    func updateBook(book: Book) {
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            guard let result: CommunicationResult<Book>? = await api.updateBook(book: book) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
//                        self.book = data
                        self.isLoading = false
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = "Failed to fetch"
                        case .badUrl:
                            self.errorMessage = "Failed to access the server"
                        case .invalidRequest:
                            self.errorMessage = "Failed to fetch"
                        case .badStatus:
                            self.errorMessage = "Failed to fetch"
                        case .failedToDecodeResponse:
                            self.errorMessage = "Failed to decode"
                        case .unknownError:
                            self.errorMessage = "unknown error"
                        }
                    case .none:
                        self.errorMessage = "unknonw error"
                    }
                    self.showError = self.errorMessage != nil
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchBookByIsbn(isbn: String) {
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            guard let result: CommunicationResult<GBooks>? = await gapi.getBookByIsbn(isbn: isbn) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        
                        if let items = data.items, let gbook = items.first {
                            self.book = gbook.convert()
                        } else {
                            errorMessage = "No such book at Google Books"
                            showError.toggle()
                        }
//                        self.isLoading = false
                        if let cover = book?.cover {
                            Task {
                                guard let result: CommunicationResult<UIImage>? = await api.downloadCover(fromUrl: cover) else {
                                    print("failed")
                                    return
                                }
                                Task {
                                    await MainActor.run {
                                        switch(result) {
                                        case .success(let data):
                                            print("succeded")
                                            self.coverImage = data
                                            self.coverImageFetchingDone = true
                                        case .failure(_):
                                            self.coverImageFetchingDone = true
                                        case .none:
                                            self.coverImageFetchingDone = true
                                        }
                                    }
                                }
                            }
                        }
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = "Failed to fetch"
                        case .badUrl:
                            self.errorMessage = "Failed to access the server"
                        case .invalidRequest:
                            self.errorMessage = "Failed to fetch"
                        case .badStatus:
                            self.errorMessage = "Failed to fetch"
                        case .failedToDecodeResponse:
                            self.errorMessage = "Failed to decode"
                        case .unknownError:
                            self.errorMessage = "unknown error"
                        }
                    case .none:
                        self.errorMessage = "unknonw error"
                    }
                    self.showError = self.errorMessage != nil
//                    self.isLoading = false
                }
            }
        }
    }

}
