//
//  GBooksApiManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class GBooksApiManager : Api, GBooksApiProtocol {
    
    private let baseUrl: String = BaseUrls.googleBooksApi.rawValue
    private let token: String = "AIzaSyCNy-ufOm_1_eiAOMIhFrMGBqMIoSAl7ho"
    
    func getBookByIsbn(isbn: String) async -> CommunicationResult<GBooks> {
        let endpoint = "volumes"

        return await self.callApi(fromURL: "\(baseUrl)\(endpoint)?q=isbn:\(isbn)&token=\(token)")
    }
    
}
