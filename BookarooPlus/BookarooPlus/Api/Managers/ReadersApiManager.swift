//
//  ReadersApiManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 05.01.2024.
//

import SwiftUI

class ReadersApiManager: BookarooApi, ReadersApiProtocol {
    
    func fetchReaders() async -> CommunicationResult<[Reader]> {
        let endpoint = "user/all_readers"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)", header: .get)
    }
    
    
    func login(login: String, password: String) async -> CommunicationResult<Reader> {
        let endpoint = "user/login"
        let params = "?login=\(login)&password=\(password)"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)\(params)", header: .post)
    }

    func register(login: String, password: String, name: String) async -> CommunicationResult<Reader> {
        let endpoint = "user/register"
        let params = "?login=\(login)&password=\(password)&name=\(name)"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)\(params)", header: .post)
    }
    
}
