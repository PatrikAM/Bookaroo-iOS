//
//  BaseView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 07.01.2024.
//

import SwiftUI

struct BaseView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        // basic contents of view
        VStack {
            Text("This is going to be the base screen")
            content
        }
    }
}
