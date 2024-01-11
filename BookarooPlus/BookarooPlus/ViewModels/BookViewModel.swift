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
    
    private let api = BooksApiManager()
    
    
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
}
