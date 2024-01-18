//
//  UserOptionsView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 11.01.2024.
//

import SwiftUI

struct UserOptionsView: View {
    
    @ObservedObject var authManager: AuthManager = .init()
    @Binding var isLoggedOut: Bool
    
    var body: some View {
        Button(action: {
            authManager.logout()
            isLoggedOut = true
            //                presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Log out")
        })
    }
}
