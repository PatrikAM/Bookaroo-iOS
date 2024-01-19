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
    
    private let defaults = UserDefaults.standard
    
    @ObservedObject var libsViewModel = ListOfLibrariesViewModel()
    @ObservedObject var booksViewModel = ListOfBooksViewModel()
    
    var body: some View {
        VStack{
            if (booksViewModel.isLoading || libsViewModel.isLoading) {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                VStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Spacer()
                            .frame(width: 60)
                        VStack {
                            if let name = defaults.string(forKey: DefaultsKey.name.rawValue) {
                                Text(name.capitalizeEachWord())
                                    .font(.headline)
                            } else {
                                Text("User".capitalizeEachWord())
                                    .font(.headline)
                            }
                            
                            Text(defaults.string(forKey: DefaultsKey.login.rawValue)!)
                        }
                        Spacer()
                    }
                    .padding(.all)
                    
                    Divider()
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        if let libCount = libsViewModel.libraries?.count {
                            Text("Libraries: \(libCount)")
                        } else {
                            Text("Libraries: none")
                        }
                        Divider()
                            .frame(height: 25)
                        Text(LocalizedStringKey("Books: \(booksViewModel.books?.count ?? 0)"))
                        
                    }
                    
                    
                    Spacer()
                        .frame(height: 20)
                    Divider()
                    Spacer()
                        .frame(height: 20)
                    
                    if let relativeBookRead = booksViewModel.relativeBookRead {
                        VStack {
                            Text("Books read from all libraries:")
                                .font(.headline)
                            ProgressView(value: relativeBookRead, label: { Text("That's pretty good!") }, currentValueLabel: { Text("\(relativeBookRead, specifier: "%.2f") %") })
                                .progressViewStyle(ProgressBarStyle(height: 30.0))
                        }
                        .padding(.all)
                    }
                    
                    Spacer()
                        .frame(height: 100)
                    
                    
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
        .onAppear{
            libsViewModel.fetchLibraries()
            booksViewModel.fetchBooks()
        }
    }
}
