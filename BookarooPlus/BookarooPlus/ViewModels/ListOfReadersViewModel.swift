//
//  ListOfReadersViewModel.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 11.01.2024.
//

import Foundation

class ListOfReadersViewModel: ObservableObject {
    
    private let api = ReadersApiManager()
    
    @Published var readers: [Reader]? = nil
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    
    func fetchReaders() {
        Task {
            guard let result: CommunicationResult<[Reader]>? = await api.fetchReaders() else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        self.readers = data
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = "Email or password incorrect"
                        case .badUrl:
                            self.errorMessage = "No internet connection"
                        case .invalidRequest:
                            self.errorMessage = "Something Failed"
                        case .badStatus:
                            self.errorMessage = "Email or password incorrect"
                        case .failedToDecodeResponse:
                            self.errorMessage = "Server answered unexpectedly"
                        case .unknownError:
                            self.errorMessage = "No internet connection"
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

