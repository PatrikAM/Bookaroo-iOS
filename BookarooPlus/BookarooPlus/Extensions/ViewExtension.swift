//
//  ViewExtionsion.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 17.01.2024.
//

import Foundation
import SwiftUI

extension View {
    func customConfirmDialog<A: View>(isPresented: Binding<Bool>, @ViewBuilder actions: @escaping () -> A) -> some View {
        return self.modifier(MyCustomModifier(isPresented: isPresented, header: nil, message: nil, actions: actions))
    }
    
    func customConfirmDialog<A: View>(isPresented: Binding<Bool>, header: Text, message: Text, @ViewBuilder actions: @escaping () -> A) -> some View {
        return self.modifier(MyCustomModifier(isPresented: isPresented, header: header, message: message, actions: actions))
    }
}

struct MyCustomModifier<A>: ViewModifier where A: View {
    
    @Binding var isPresented: Bool
    let header: (Text)?
    let message: (Text)?
    @ViewBuilder let actions: () -> A
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ZStack(alignment: .bottom) {
                if isPresented {
                    Color.primary.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                                isPresented = false
                        }
                        .transition(.opacity)
                }
                
                if isPresented {
                    VStack {
                        GroupBox {
                            if let hdr = header {
//                                Text(hdr)
                                hdr
                                    .font(.headline)
                                Divider()
                            }
                            if let msg = message {
//                                Text(msg)
                                msg
                            }
                        }
                        GroupBox {
                            actions()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        GroupBox {
                            Button("Cancel", role: .cancel) {
                                    isPresented = false
                            }
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .font(.title3)
                    .padding(8)
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeInOut, value: isPresented)
   }
}
