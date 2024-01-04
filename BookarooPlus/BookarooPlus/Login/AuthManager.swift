//
//  AuthManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func login() {
        isLoading = true
        errorMessage = nil
        
    }
    
    func logout() {
        isLoading = true
        errorMessage = nil
        
    }
    
    func signin() {
        isLoading = true
        errorMessage = nil
        
    }
}

