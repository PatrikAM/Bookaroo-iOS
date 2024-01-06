//
//  SplashView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var timeIsGone = false
    
    let authManager = AuthManager()
    
    var body: some View {
        VStack {
            if (timeIsGone) {
                
                if (!authManager.isUserSignedIn()) {
                    LoginView()
                        .transition(.opacity)
                    //                        .opacity(opacityFull ? 1.0 : 0)
                    //                        .onAppear() {
                    //                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    //                                opacityFull.toggle()
                    //                            }
                    //                        }
                    //                        .transition(.slide)
                } else {
                    // landing view
                }
            } else {
                Image(AssetsConstants.logotyp.rawValue)
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .opacity(phase ? 1.0 : 0)
                    } animation: { phase in
                            .easeInOut(duration: 1.1)
                    }
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    timeIsGone.toggle()
                }
            }
        }
    }
}
