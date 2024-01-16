//
//  BaseView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 07.01.2024.
//

import SwiftUI
import TabBarModule

struct BaseView: View {

//    @State private var item: Int = 0
    @Binding var didLogout: Bool
    
    var body: some View {
        
//        TabBar(selection: $item) {
//            ListOfBooksView(isLoggedOut: $didLogout)
//                .tabItem(0) {
//                    Image(systemName: item == 0 ? "book.fill" : "book")
//                        .font(.title3)
//                    Text("Books")
//                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
//                }
//            ListOfReadersView()
//                .tabItem(1) {
//                    Image(systemName: item == 1 ? "person.fill" : "person")
//                        .font(.title3)
//                    Text("Readers")
//                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
//                }
//            ListOfLibrariesView()
//                .tabItem(2) {
//                    Image(systemName: item == 2 ? "building.columns.fill" : "building.columns")
//                        .font(.title3)
//                    Text("Libraries")
//                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
//                }
//            UserOptionsView(isLoggedOut: $didLogout)
//                .tabItem(3) {
//                    Image(systemName: item == 3 ? "person.crop.circle.fill" : "person.crop.circle")
//                        .font(.title3)
//                    Text("User Settings")
//                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
//                }
//        }
//        .tabBarFill(.regularMaterial)
//        .tabBarMargins(.vertical, 8)
//        .tabBarPadding(.vertical, 8)
//        .tabBarPadding(.horizontal, 16)
//        .tabBarShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
//        .tabBarShadow(radius: 1, y: 1)
        
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
            UserOptionsView(isLoggedOut: $didLogout)
                .tabItem {
                    Label("User Settings", systemImage: "person.crop.circle")
                }
        }
    
        
        //            }
        //        }
        
    }
    
}

