//
//  BooksApiManagerProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

protocol BooksApiManagerProtocol {
    
    func fetchBooks() async -> CommunicationResult<[Book]>
    
    func fetchBook(bookId: String) async -> CommunicationResult<Book>
    
    func fetchBooksFromLibrary(libraryId: String) async -> CommunicationResult<[Book]>
    
    func createBook(book: Book) async -> CommunicationResult<Book>
    
    func updateBook(book: Book) async -> CommunicationResult<Book>
    
    func deleteBook(bookId: String) async -> CommunicationResult<Book>
    
}
