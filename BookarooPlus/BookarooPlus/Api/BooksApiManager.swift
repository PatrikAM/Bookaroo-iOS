//
//  BooksApiManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class BooksApiManager : Api, BooksApiManagerProtocol {
    func fetchBooks() -> CommunicationResult<[Book]> {
        <#code#>
    }
    
    func fetchBook(bookId: String) -> CommunicationResult<Book> {
        <#code#>
    }
    
    func fetchBooksFromLibrary(libraryId: String) -> CommunicationResult<[Book]> {
        <#code#>
    }
    
    func createBook(book: Book) -> CommunicationResult<Book> {
        <#code#>
    }
    
    func updateBook(book: Book) -> CommunicationResult<Book> {
        <#code#>
    }
    
    func deleteBook(bookId: String) -> CommunicationResult<Book> {
        <#code#>
    }
    
}
