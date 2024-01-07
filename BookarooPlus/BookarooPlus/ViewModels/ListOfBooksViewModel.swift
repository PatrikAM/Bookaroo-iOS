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
    
    
    func fetchBooks() {
        Task {
            guard let result: CommunicationResult<[Book]>? = await api.fetchBooks() else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        print(data)
                        self.books = data
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = "Failed to log in"
                        case .badUrl:
                            self.errorMessage = "Failed to access the server"
                        case .invalidRequest:
                            self.errorMessage = "Failed"
                        case .badStatus:
                            self.errorMessage = "Bad credentials"
                        case .failedToDecodeResponse:
                            self.errorMessage = "Failed to decode"
                        case .unknownError:
                            self.errorMessage = "unknown error"
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
    
}
