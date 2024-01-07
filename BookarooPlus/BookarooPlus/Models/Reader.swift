//
//  Reader.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

struct Reader: Codable, DictionaryEncodable, Equatable {
    var id: String?
    var name: String?
    var login: String?
    // var password: String?
    var token: String?
}
