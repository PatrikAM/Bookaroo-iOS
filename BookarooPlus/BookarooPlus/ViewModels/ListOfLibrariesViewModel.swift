//
//  ListOfLibrariesViewModel.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 08.01.2024.
//

import Foundation

class ListOfLibrariesViewModel: ObservableObject {
    
    private let api = LibrariesApiManager()
//    private let booksApi = BooksApiManager()
    
    @Published var libraries: [Library]? = nil
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    
    
    func fetchLibraries() {
        Task {
            guard let result: CommunicationResult<[Library]>? = await api.fetchLibraries() else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        var defaultedData = data
                        defaultedData.indices.forEach { defaultedData[$0].isSelected = false }
                        self.libraries = defaultedData
                        print(self.libraries)
                        self.isLoading = false
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
//                    self.isLoading = false
                    
                }
            }
        }
    }
    
    // do NOT delete underscore, this makes the function a callback
    func addLibrary(_ libraryName: String) {
        // TODO: fill in functionality for adding a library
        Task {
            guard let result: CommunicationResult<Library>? = await api.createLibrary(library: libraryName) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        var defaultedData = data
                        self.libraries?.append(data)
//                        defaultedData.indices.forEach { defaultedData[$0].isSelected = false }
//                        self.libraries = defaultedData
//                        print(self.libraries)
                        self.isLoading = false
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
//                    self.isLoading = false
                    
                }
            }
        }
    }
    
}

