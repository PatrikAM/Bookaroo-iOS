//
//  CommunicationResult.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

enum CommunicationResult<T> {
    case success(T)
    case failure(Error)
}
