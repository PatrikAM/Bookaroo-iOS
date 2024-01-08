//
//  BaseView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 07.01.2024.
//

import SwiftUI

struct BaseView: View {
//    @ObservedObject var authManager = AuthManager()
//    @State var didLoginSucceed: Bool = false
    
    @Binding var didLogout: Bool
    
    var body: some View {
        //        Group {
        //            if (!authManager.isUserSignedIn() && !didLoginSucceed) {
        //                Text("loggedout")
        //                LoginView(didLoginSucceed: $didLoginSucceed)
        //                    .transition(.opacity)
        //                    .toolbar(.hidden, for: .tabBar)
        //            } else {
        TabView {
            ListOfBooksView(isLoggedOut: $didLogout)
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
        
        //            }
        //        }
        
    }
    
}

