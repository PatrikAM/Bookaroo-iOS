//
//  NavigateView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 05.01.2024.
//

import SwiftUI

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                        .background(.clear)
                }
                .background(.clear)
            }
            .background(.clear)
        }
        .background(.clear)
        .navigationViewStyle(.stack)
        
    }
}

