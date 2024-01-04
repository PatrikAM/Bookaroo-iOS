//
//  CommunicationError.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation
enum CommunicationError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
    case unknownError
}
