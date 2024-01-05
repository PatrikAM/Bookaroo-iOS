//
//  LoginView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import AlertToast
import SwiftUI

struct LoginView: View {
    
    //    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @ObservedObject var authManager: AuthManager = AuthManager()
    
    var body: some View {
        
        VStack {
            
            Image(AssetsConstants.logotyp.rawValue)
            
            VStack {
                TextField(
                    "Email",
                    text: $authManager.email
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                SecureField(
                    "Password",
                    text: $authManager.password
                )
                .padding(.top, 20)
                
                Divider()
            }
            
            Spacer()
            
            Button(
                action: authManager.login,
                label: {
                    Text("Login")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            )
            .disabled(authManager.isLoading)
            
            // LoginScreenEllipseShape().frame(width: .infinity, height: 500)
            
            
            
        }
        .navigate(to: ListOfBooksView(), when: $authManager.navigate)
        .toast(isPresenting: $authManager.isErrorToastShown) {
            AlertToast(
                displayMode: .alert,
                type: .error(Color.red),
                subTitle: authManager.errorMessage
            )
        }
        .padding(30)
        
    }
}
