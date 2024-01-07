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
    @ObservedObject var authManager: AuthManager = .init()
    @Binding var didLoginSucceed: Bool
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                LoginScreenEllipseShape()
                    .fill(Colors.accentBlue)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                    .frame(height: 500)
                
                VStack {
                    HStack {
                        Spacer()
                        Image(AssetsConstants.logotyp.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                            .background(.clear)
                        Spacer()
                    }
                    
                    
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
                    .background(.clear)
                    
                    Spacer()
                        .background(.clear)
                    
                    Button(
                        action: {
                            clearFocus()
                            Task {
                                authManager.login()
//                                didLoginSucceed = true
                            }
                        },
                        label: {
                            Text("Log in")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    )
                    .disabled(authManager.isLoading)
                    .buttonStyle(PlainButtonStyle())
                }
                .toast(isPresenting: $authManager.isErrorToastShown) {
                    AlertToast(
                        displayMode: .alert,
                        type: .error(Color.red),
                        subTitle: authManager.errorMessage
                    )
                }
                .background(.clear)
                .padding(30)
                .onTapGestureClearFocus()
//                .onTapGesture {
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }
            }
            .background(.clear)
            .onTapGestureClearFocus()
            .onChange(of: authManager.didLoginSucceed) {
                didLoginSucceed = authManager.didLoginSucceed
            }
            //.navigationDestination(for: $didLoginSucceed, destination: ListOfBooksView())
        }
    }
        
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
