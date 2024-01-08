//
//  SplashView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var timeIsGone: Bool
    
    var body: some View {
        VStack {
            if (timeIsGone) {
//                BaseView()
            } else {
                Image(AssetsConstants.logotyp.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .opacity(phase ? 1.0 : 0)
                    } animation: { phase in
                            .easeInOut(duration: 1.1)
                    }

//                ZStack {
//                    Image(AssetsConstants.logotyp.rawValue)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .phaseAnimator([false, true]) { content, phase in
//                            content
//                                .opacity(phase ? 1.0 : 0)
//                        } animation: { phase in
//                                .easeInOut(duration: 1.1)
//                        }
//                }
//
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
