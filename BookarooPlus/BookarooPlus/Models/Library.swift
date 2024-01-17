//
//  Library.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

struct Library: Identifiable, Codable, DictionaryEncodable, Hashable {
    var id: String
    var name: String?
    var ownerId: String?
    var favourite: Int? = 0
    var total: Int? = 0
    var read: Int? = 0
    var isSelected: Bool? = false
}
