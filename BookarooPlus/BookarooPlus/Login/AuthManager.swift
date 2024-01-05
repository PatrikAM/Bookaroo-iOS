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
    @Published var name: String = ""
    
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    @Published var isErrorToastSowing: Bool = false
    
    @Published var data: Reader? = nil
    
    @Published var navigate: Bool = false
    
    let api = ReadersApiManager()
    
    private let defaults = UserDefaults.standard
    
    func login() {
        
        if self.password.isEmpty || self.email.isEmpty {
            self.isLoading = false
            self.errorMessage = "Please fill credentials in"
            self.isErrorToastSowing = true
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
                        print(data)
                        self.data = data
                        self.navigate = true
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
                        self.isErrorToastSowing = true
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
    
    func logout() {
        isLoading = true
        errorMessage = nil
        
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
    }
    
    func signin() {
        
        if self.password.isEmpty || self.email.isEmpty {
            self.isLoading = false
            self.errorMessage = "Please fill credentials in"
            self.isErrorToastSowing = true
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
                        self.navigate = true
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
                        self.isErrorToastSowing = true
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
}
