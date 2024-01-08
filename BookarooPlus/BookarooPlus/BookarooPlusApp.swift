//
//  BookarooPlusApp.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 01.01.2024.
//

import SwiftUI

enum Screen {
    case login
    case home
}

@main
struct BookarooPlusApp: App {
    
    @ObservedObject var authManager = AuthManager()
    @State var didLoginSucceed: Bool = false
    @State var didLogout: Bool = false
    @State var timeIsGone: Bool = false
        
    @State var screen: Screen = .login
    
    var body: some Scene {
        WindowGroup {
            if !timeIsGone {
                SplashView(timeIsGone: $timeIsGone)
                    .onAppear() {
                        didLoginSucceed = authManager.isUserSignedIn()
                    }
            } else {
                Group {
                    switch screen {
                    case .login:
                        LoginView(didLoginSucceed: $didLoginSucceed)
                    case .home:
                        BaseView(didLogout: $didLogout)
                    }
                }
            }
            
        }
        .onChange(of: didLoginSucceed) {
            if (didLoginSucceed) {
                screen = .home
            }
            didLoginSucceed = false
            
        }
        .onChange(of: didLogout) {
            if (didLogout) {
                screen = .login
            }
            didLogout = false
        }
    }
}
