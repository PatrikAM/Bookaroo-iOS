//
//  BooksApiManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class BooksApiManager : BookarooApi, BooksApiProtocol {
        
    func fetchBooks() async -> CommunicationResult<[Book]> {
        let endpoint = "book/all_books"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)?token=\(String(describing: self.token))")
    }
    
    func fetchBook(bookId: String) async -> CommunicationResult<Book> {
        let endpoint = "book"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(bookId)?token=\(String(describing: self.token))")
    }
    
    func fetchBooksFromLibrary(libraryId: String) async -> CommunicationResult<[Book]> {
        let endpoint = "book/find_by_library"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(libraryId)?token=\(String(describing: self.token))")
    }
    
    func createBook(book: Book) async -> CommunicationResult<Book> {
        let endpoint = "book"
        let bookDict = book.dictionary()
        
        let params = super.buildParams(fromObject: book, token: self.token!)
        
//        var params = "?token=\(String(describing: token))"
//        book.dictionary()?.forEach({ (key: String, value: Any?) in
//            if let val = value {
//                params += "&\(key)=\(String(describing: value))"
//            }
//        })
        
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)?\(params)")
    }
    
    func updateBook(book: Book) async -> CommunicationResult<Book> {
        let endpoint = "book/update"
        let bookDict = book.dictionary()
        
        let params = super.buildParams(fromObject: book, token: self.token!)
        
//        var params = "?token=\(String(describing: token))"
//        book.dictionary()?.forEach({ (key: String, value: Any?) in
//            if let val = value {
//                params += "&\(key)=\(String(describing: value))"
//            }
//        })
        
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)?\(params)")
    }
    
    func deleteBook(bookId: String) async -> CommunicationResult<Book> {
        let endpoint = "book/remove_by_id"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(bookId)?token=\(String(describing: token))")
    }
    
}
