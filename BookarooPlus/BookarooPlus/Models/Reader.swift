//
//  Reader.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

struct Reader: Codable {
    var id: String?
    var name: String?
    var login: String?
    // var password: String?  // Password field is commented out as it's typically not recommended to include passwords in plain text in code
    var token: String?
}
