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
                        self.errorMessage = APIErrorsConstants.unknownError.rawValue
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
            isLoading = true
            errorMessage = nil
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
                        self.errorMessage = APIErrorsConstants.unknownError.rawValue
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

