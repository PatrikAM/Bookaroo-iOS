//
//  Book.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

struct Book: Identifiable, Codable, DictionaryEncodable {
    var id: String? = nil
    var isbn: String? = nil
    var library: String? = nil
    var author: String? = nil
    var title: String? = nil
    var subtitle: String? = nil
    var pages: Int? = nil
    var cover: String? = nil
    var description: String? = nil
    var publisher: String? = nil
    var published: String? = nil
    let language: String? = nil
    
//    init(id: String? = nil,
//         isbn: String? = nil,
//         library: String? = nil,
//         author: String? = nil,
//         title: String? = nil,
//         subtitle: String? = nil,
//         pages: Int? = nil,
//         cover: String? = nil,
//         description: String? = nil,
//         publisher: String? = nil,
//         published: String? = nil,
//         language: String? = nil) {
//        self.id = id
//        self.isbn = isbn
//        self.library = library
//        self.author = author
//        self.title = title
//        self.subtitle = subtitle
//        self.pages = pages
//        self.cover = cover
//        self.description = description
//        self.publisher = publisher
//        self.published = published
//        self.language = language
//    }
}

struct Books: Codable {
    var books: [Book]? = nil
}
