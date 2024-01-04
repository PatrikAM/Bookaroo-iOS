//
//  GBook.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

struct GBooks: Codable {
    let totalItems: Int?
    let items: [GBook]?
}

struct GBook: Codable {
    let id: String?
    let volumeInfo: VolumeInfo?

    func convert() -> Book {
        return Book(
            author: volumeInfo?.authors?.first,
            title: volumeInfo?.title,
            pages: volumeInfo?.pageCount,
            cover: volumeInfo?.imageLinks?.first,
            publisher: volumeInfo?.publisher,
            published: volumeInfo?.publishedDate
        )
    }
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let categories: [String]?
    let language: String?
    let imageLinks: [String]?
    let printType: String?
}
