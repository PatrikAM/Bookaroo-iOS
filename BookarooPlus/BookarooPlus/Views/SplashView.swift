//
//  SplashView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var timeIsGone = false
    
    var body: some View {
        VStack {
            if (timeIsGone) {
                BaseView()
            } else {
                Image(AssetsConstants.logotyp.rawValue)
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
//                .frame(width: 300, height: 300)
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    timeIsGone.toggle()
                }
            }
        }
    }
}
