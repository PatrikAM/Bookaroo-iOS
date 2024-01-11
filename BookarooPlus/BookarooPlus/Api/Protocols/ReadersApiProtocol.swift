//
//  ReadersApiProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

protocol ReadersApiProtocol {
    
    func login(login: String, password: String) async -> CommunicationResult<Reader>
    
    func register(login: String, password: String, name: String) async -> CommunicationResult<Reader>
    
    func fetchReaders() async -> CommunicationResult<[Reader]>
    
//    func logout() -> CommunicationResult<BookarooApiResponse>
    
//    func closeAccount() -> CommunicationResult<BookarooApiResponse>
    
}
