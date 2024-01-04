//
//  Book.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

struct Book: Identifiable, Codable {
    var id: String?
    var isbn: String?
    var library: String?
    var author: String?
    var title: String?
    var subtitle: String?
    var pages: Int?
    var cover: String?
    var description: String?
    var publisher: String?
    var published: String?
    let language: String?
    
    init(id: String? = nil,
         isbn: String? = nil,
         library: String? = nil,
         author: String? = nil,
         title: String? = nil,
         subtitle: String? = nil,
         pages: Int? = nil,
         cover: String? = nil,
         description: String? = nil,
         publisher: String? = nil,
         published: String? = nil,
         language: String? = nil) {
        self.id = id
        self.isbn = isbn
        self.library = library
        self.author = author
        self.title = title
        self.subtitle = subtitle
        self.pages = pages
        self.cover = cover
        self.description = description
        self.publisher = publisher
        self.published = published
        self.language = language
    }
}
