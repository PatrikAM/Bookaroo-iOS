//
//  BaseView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 07.01.2024.
//

import SwiftUI

struct BaseView: View {
    @StateObject var authManager = AuthManager()
    @State var didLoginSucceed: Bool = false
    
    var body: some View {
        
        if (!authManager.isUserSignedIn() && !didLoginSucceed) {
            Text("loggedout")
            LoginView(didLoginSucceed: $didLoginSucceed)
                .transition(.opacity)
        } else {
            TabView {
                ListOfBooksView()
                    .tabItem {
                        Label("Books", systemImage: "book")
                    }
                ListOfReadersView()
                    .tabItem {
                        Label("Readers", systemImage: "person")
                    }
                ListOfLibrariesView()
                    .tabItem {
                        Label("Libraries", systemImage: "building.columns")
                    }
            }
        }
        
    }
    
}

