//
//  LibrariesApiProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

protocol LibrariesApiProtocol {
    func fetchLibraries() async -> CommunicationResult<[Library]>
    func createLibrary(library: String) async -> CommunicationResult<Library>
}
