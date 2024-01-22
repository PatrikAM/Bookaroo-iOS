//
//  APIErrorsConstants.swift
//  BookarooPlus
//
//  Created by Marek Glas on 22.01.2024.
//

import Foundation

enum APIErrorsConstants: String {
    case loginFailed = "login_failed" // failed to log in
    case badUrl = "bad_url" // failed to access server
    case invalidRequest = "invalid_request" // data download failed
    case badStatusCode = "bad_credentials" // bad login credentials. try again or log out
    case failedToDecodeResponse = "response_decode_fail" // there was an issue collecting your data. please try again
    case unknownError = "unknown_error" // unknown error, try again
}
