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
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
                VStack {
                    Text("Testing User".capitalizeEachWord())
                        .font(.headline)
                    
                    Text("Account Created: ???")
                        .font(.subheadline)
                }
            }
            
            Spacer()
                .frame(height: 20)
            Divider()
            Spacer()
                .frame(height: 20)
            
            VStack {
                Text("Libraries: 3")
                Text("Books: 256")
                Text("Preferred language: Czech")
            }
            
            
            Spacer()
                .frame(height: 20)
            Divider()
            Spacer()
                .frame(height: 20)
            
            VStack {
                Text("Books read from all libraries")
                ProgressView(value: 0.4, label: { Text("That's pretty good!") }, currentValueLabel: { Text("40 %") })
                    .progressViewStyle(ProgressBarStyle(height: 30.0))
            }
            .padding(.all)
            
            
            
            Button(action: {
                authManager.logout()
                isLoggedOut = true
                //                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Log out")
            })
            .buttonStyle(.borderedProminent)
        }
        
    }
}
