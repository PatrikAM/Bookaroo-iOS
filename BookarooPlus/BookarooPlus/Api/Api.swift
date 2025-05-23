//
//  ApiProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class Api {
    
    func callApi<T: Codable>(
        fromURL: String,
        header: Header = .get,
        body: Data? = nil
    ) async -> CommunicationResult<T> {
        do {
            guard let url = URL(string: fromURL) else { throw CommunicationError.badUrl }
            var request = URLRequest(url: url)
            request.httpMethod = header.rawValue
            if (body != nil) {
                request.httpBody = body
            }
            
            print(request.httpMethod)
            print(header.rawValue)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw CommunicationError.badResponse }
//            let dataPrep = String(data: data, encoding: .utf8)!
            
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw CommunicationError.badStatus }
            
            //            let decoded = try JSONDecoder().decode([Book].self, from: data)
            //            print(decoded)
            //
            //            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw CommunicationError.failedToDecodeResponse }
            
            return .success(decodedResponse)
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
    
    func buildParams(fromObject: DictionaryEncodable, token: String) -> String {
        var params = "?token=\(String(describing: token))"
        fromObject.dictionary()?.forEach({ (key: String, value: Any?) in
            if let val = value {
                if let bool = val as? Bool {
                    params += "&\(key)=\(bool ? "true" : "false")"
                } else {
                    params += "&\(key)=\(val)"
                }
            }
        })
        
        return params
    }
    
}
