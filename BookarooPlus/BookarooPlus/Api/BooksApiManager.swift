//
//  BooksApiManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class BooksApiManager : Api, BooksApiManagerProtocol {
    
    private let baseUrl: String = BaseUrls.bookaroo.rawValue
        
    func fetchBooks() async -> CommunicationResult<[Book]> {
        let endpoint = "book/all_books"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)")
    }
    
    func fetchBook(bookId: String) async -> CommunicationResult<Book> {
        let endpoint = "book"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(bookId)")
    }
    
    func fetchBooksFromLibrary(libraryId: String) async -> CommunicationResult<[Book]> {
        let endpoint = "book/find_by_library"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(libraryId)")
    }
    
    func createBook(book: Book) async -> CommunicationResult<Book> {
        let endpoint = "book"
        let bookDict = book.dictionary()
        
        var params = ""
        book.dictionary()?.forEach({ (key: String, value: Any?) in
            if let val = value {
                params += "&\(key)=\(String(describing: value))"
            }
        })
        
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)?\(params.dropFirst())")
    }
    
    func updateBook(book: Book) async -> CommunicationResult<Book> {
        let endpoint = "book/update"
        let bookDict = book.dictionary()
        
        var params = ""
        book.dictionary()?.forEach({ (key: String, value: Any?) in
            if let val = value {
                params += "&\(key)=\(String(describing: value))"
            }
        })
        
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)?\(params.dropFirst())")
    }
    
    func deleteBook(bookId: String) async -> CommunicationResult<Book> {
        let endpoint = "book/remove_by_id"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(bookId)")
    }
    
//    private func buildBookParamsString(book: Book) -> String {
//        var params: String = "?author=\(String(describing: book.author))"
//        params += "&library=\(String(describing: book.library))"
//        params += "&title=\(String(describing: book.title))"
//        
//        params += buildParam(key: "isbn", value: "")
//        
//        return params
//    }
//    
//    private func buildParam(key: String, value: String?) -> String {
//        if let value = value {
//            return "&\(key)=\(value)"
//        }
//        
//        return ""
//    }
    
}
