//
//  AuthManager.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var email: String = "example@ex.com"
    @Published var password: String = "pass.123"
    @Published var name: String = "John"
    
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    @Published var isErrorToastShown: Bool = false
    
    @Published var data: Reader? = nil
    
//    @Published var navigate: Bool = false
    @Published var didLoginSucceeded: Bool = false
    
    let api = ReadersApiManager()
    
    private let defaults = UserDefaults.standard
    
    func login() {
        
        if self.password.isEmpty || self.email.isEmpty {
            self.isLoading = false
            self.errorMessage = "Please fill credentials in"
            self.isErrorToastShown = true
            return
        }
        
        let login = email
        let pass = self.password
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            guard let result: CommunicationResult<Reader>? = await api.login(login: login, password: pass) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        self.data = data
                        self.defaults.set(self.email.lowercased(), forKey: "login")
                        self.defaults.set(data.id!, forKey: DefaultsKey.token.rawValue)
                        self.defaults.synchronize()
                        self.didLoginSucceeded = true
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = "Failed to log in"
                        case .badUrl:
                            self.errorMessage = "Failed to access the server"
                        case .invalidRequest:
                            self.errorMessage = "Failed"
                        case .badStatus:
                            self.errorMessage = "Bad credentials"
                        case .failedToDecodeResponse:
                            self.errorMessage = "Failed to decode"
                        case .unknownError:
                            self.errorMessage = "unknown error"
                        }
                        self.isLoading = false
                        self.isErrorToastShown = true
                        return
                    case .none:
                        self.errorMessage = "unknonw error"
                        print("total failure")
                        self.isLoading = false
                        return
                    }
                    print("setting")
                    // if it worked
                    self.isLoading = false
                    
                }
            }
        }
    }
    
    func logout() {
        isLoading = true
        errorMessage = nil
        
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
    }
    
    func signup() {
        
        if self.password.isEmpty || self.email.isEmpty {
            self.isLoading = false
            self.errorMessage = "Please fill credentials in"
            self.isErrorToastShown = true
            return
        }
        
        let login = email
        let pass = self.password
        let name = self.name
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            guard let result: CommunicationResult<Reader>? = await api.register(login: login, password: pass, name: name) else {return}
            Task {
                await MainActor.run {
                    switch(result) {
                    case .success(let data):
                        print(data)
                        self.data = data
                        self.didLoginSucceeded = true
                    case .failure(let error):
                        switch(error) {
                        case(.badResponse):
                            self.errorMessage = "Failed to log in"
                        case .badUrl:
                            self.errorMessage = "Failed to access the server"
                        case .invalidRequest:
                            self.errorMessage = "Failed"
                        case .badStatus:
                            self.errorMessage = "Bad credentials"
                        case .failedToDecodeResponse:
                            self.errorMessage = "Failed to decode"
                        case .unknownError:
                            self.errorMessage = "unknown error"
                        }
                        self.isLoading = false
                        self.isErrorToastShown = true
                        return
                    case .none:
                        self.errorMessage = "unknonw error"
                        print("total failure")
                        self.isLoading = false
                        return
                    }
                    print("setting")
                    // if it worked
                    self.defaults.set(self.email.lowercased(), forKey: "login")
                    self.defaults.set(data?.id, forKey: "token")
                    // user id
                    //        defaults.set(email.lowercased(), forKey: "token")
                    self.defaults.synchronize()
                    self.isLoading = false
                    
                }
            }
        }
        
    }
    
    func isUserSignedIn() -> Bool {
        return defaults.string(forKey: DefaultsKey.token.rawValue) != nil
    }
}
