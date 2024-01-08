//
//  LibrariesApiManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 08.01.2024.
//

import Foundation

class LibrariesApiManager: BookarooApi, LibrariesApiProtocol {
    func fetchLibraries() async -> CommunicationResult<[Library]> {
        let endpoint = "library/all_libraries"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)?token=\(self.token!)")
    }
    
    func createLibrary(library: String) async -> CommunicationResult<Library> {
        let endpoint = "library"
        return await super.callApi(
            fromURL: "\(baseUrl)\(endpoint)?token=\(self.token!)?token=\(self.token!)&name=\(library)",
            header: .post
        )
    }
    
    
}
