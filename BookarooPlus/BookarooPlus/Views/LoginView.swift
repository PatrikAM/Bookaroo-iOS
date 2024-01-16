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
    @State var isRegistration = false
    @State var isProcessing = false
    
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
                    
                    Spacer()
                        .frame(height: 100)
                    
                    VStack {
                        TextField(
                            "Email",
                            text: $authManager.email
                        )
                        .textFieldStyle(ElegantTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.top, 20)
                        
                        if (isRegistration) {
                            TextField(
                                "Nickname",
                                text: $authManager.name
                            )
                            .textFieldStyle(ElegantTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.top, 20)
                        }
                        
                        SecureField(
                            "Password",
                            text: $authManager.password
                        )
                        .textFieldStyle(ElegantTextFieldStyle())
                        .padding(.top, 20)
                        
                        Button(action: {
                            isRegistration.toggle()
                        }, label: {
                            if(isRegistration) {
                                Text("Already registered? Log in")
                            } else {
                                Text("No account? Register here")
                            }
                            
                        })
                        
                        //                        NavigationLink("No account? Register here") {
                        //                            RegistrationView()
                        //                        }
                    }
                    .background(.clear)
                    
                    Spacer()
                        .background(.clear)
                    
                    Button(
                        action: {
                            clearFocus()
                            isProcessing.toggle()
                            if (isRegistration) {
                                Task {
                                    authManager.signup()
                                }
                            } else {
                                Task {
                                    authManager.login()
                                    //                                didLoginSucceed = true
                                }
                            }
                        },
                        label: {
                            if (!isRegistration) {
                                Text("Log in")
                                    .font(.system(size: 24, weight: .bold, design: .default))
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            } else {
                                Text("Register")
                                    .font(.system(size: 24, weight: .bold, design: .default))
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            
                        }
                    )
                    .disabled(authManager.isLoading)
                    .buttonStyle(PlainButtonStyle())
                    .tint(Color.accentColor)
                }
                .toast(isPresenting: $authManager.isErrorToastShown) {
                    AlertToast(
                        displayMode: .alert,
                        type: .error(Color.red),
                        subTitle: authManager.errorMessage
                    )
                }
                .toast(isPresenting: $authManager.isLoading) {
                    AlertToast(displayMode: .alert, type: .loading, subTitle: "Loading...")
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
                self.didLoginSucceed = authManager.didLoginSucceed
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
