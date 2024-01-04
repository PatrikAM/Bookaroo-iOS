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
    
    private let defaults = UserDefaults.standard
    
    func login() {
        isLoading = true
        errorMessage = nil
        
        // if it worked
        defaults.set(email.lowercased(), forKey: "login")
        // user id
//        defaults.set(email.lowercased(), forKey: "token")
        defaults.synchronize()
    }
    
    func logout() {
        isLoading = true
        errorMessage = nil
        
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
    }
    
    func signin() {
        isLoading = true
        errorMessage = nil
        
    }
}

