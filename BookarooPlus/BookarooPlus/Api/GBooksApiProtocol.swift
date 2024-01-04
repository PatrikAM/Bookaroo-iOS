//
//  GBooksApiProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

protocol GBooksApiProtocol {
    
    func getBookByIsbn(isbn: String) -> CommunicationResult<GBooks>
    
}
