//
//  LibrariesApiProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

protocol LibraryRemoteRepository {
    func fetchLibraries() -> CommunicationResult<[Library]>
    func createLibrary(library: String) -> CommunicationResult<Library>
}
