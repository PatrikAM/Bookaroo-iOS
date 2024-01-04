//
//  BooksApiManagerProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

protocol BooksApiManagerProtocol {
    
    func fetchBooks() -> CommunicationResult<[Book]>
    
    func fetchBook(bookId: String) -> CommunicationResult<Book>
    
    func fetchBooksFromLibrary(libraryId: String) -> CommunicationResult<[Book]>
    
    func createBook(book: Book) -> CommunicationResult<Book>
    
    func updateBook(book: Book) -> CommunicationResult<Book>

    func deleteBook(bookId: String) -> CommunicationResult<Book>
    
}
