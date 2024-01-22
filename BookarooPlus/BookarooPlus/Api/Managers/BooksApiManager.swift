//
//  BooksApiManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation
import UIKit

class BooksApiManager : BookarooApi, BooksApiProtocol {
    
    func downloadCover(fromUrl: String) async -> CommunicationResult<UIImage> {
        do {
            guard let url = URL(string: fromUrl) else { throw CommunicationError.badUrl }
            var request = URLRequest(url: url)
            request.httpMethod = Header.get.rawValue
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw CommunicationError.badResponse }
            //            let dataPrep = String(data: data, encoding: .utf8)!
            
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw CommunicationError.badStatus }
            
            //            let decoded = try JSONDecoder().decode([Book].self, from: data)
            //            print(decoded)
            //
            //            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            
            //            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw CommunicationError.failedToDecodeResponse }
            
            return .success(UIImage(data: data)!)
        } catch CommunicationError.badUrl {
            print("There was an error creating the URL")
            return .failure(CommunicationError.badUrl)
        } catch CommunicationError.badResponse {
            print("Did not get a valid response")
            return .failure(CommunicationError.badResponse)
        } catch CommunicationError.badStatus {
            print("Did not get a 2xx status code from the response")
            return .failure(CommunicationError.badStatus)
        } catch CommunicationError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
            return .failure(CommunicationError.failedToDecodeResponse)
        } catch {
            print(error.localizedDescription)
            print(String(describing: error))
            print("An error occured downloading the data")
            return .failure(CommunicationError.unknownError)
        }
    }
    
    
    func fetchBooks() async -> CommunicationResult<[Book]> {
        let endpoint = "book/all_books"
        if let tok = token {
            return await super.callApi(fromURL: "\(baseUrl)\(endpoint)?token=\(self.token!)")
        } else {
            return CommunicationResult.failure(.unknownError)
        }
    }
    
    func fetchBook(bookId: String) async -> CommunicationResult<Book> {
        let endpoint = "book"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(bookId)?token=\(self.token!)")
    }
    
    func fetchBooksFromLibrary(libraryId: String) async -> CommunicationResult<[Book]> {
        let endpoint = "book/find_by_library"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(libraryId)?token=\(self.token!)")
    }
    
    func createBook(book: Book) async -> CommunicationResult<Book> {
        let endpoint = "book"
        //        let bookDict = book.dictionary()
        
        let params = super.buildParams(fromObject: book, token: self.token!)
        
        //        var params = "?token=\(String(describing: token))"
        //        book.dictionary()?.forEach({ (key: String, value: Any?) in
        //            if let val = value {
        //                params += "&\(key)=\(String(describing: value))"
        //            }
        //        })
        print("\(baseUrl)\(endpoint)\(params)")
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)\(params)", header: .post)
    }
    
    func updateBook(book: Book) async -> CommunicationResult<Book> {
        let endpoint = "book"
        //        let bookDict = book.dictionary()
        
        let params = super.buildParams(fromObject: book, token: self.token!)
        
        //        var params = "?token=\(String(describing: token))"
        //        book.dictionary()?.forEach({ (key: String, value: Any?) in
        //            if let val = value {
        //                params += "&\(key)=\(String(describing: value))"
        //            }
        //        })
        
        return await super.callApi(
            fromURL: "\(baseUrl)\(endpoint)?token=\(token!)",
            header: .put,
            body: try? JSONSerialization.data(withJSONObject: book.dictionary()!)
        )
    }
    
    func deleteBook(bookId: String) async -> CommunicationResult<Book> {
        let endpoint = "book/remove_by_id"
        return await super.callApi(fromURL: "\(baseUrl)\(endpoint)/\(bookId)?token=\(self.token!)")
    }
    
}
