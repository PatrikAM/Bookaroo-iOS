//
//  ElegantTextFieldStyle.swift
//  BookarooPlus
//
//  Created by User on 07.01.2024.
//

import SwiftUI

struct ElegantTextFieldStyle: TextFieldStyle {
    @Environment(\.colorScheme) var colorScheme
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.all)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(colorScheme == .dark ? Color(UIColor.systemGray4) : Color(UIColor.black), lineWidth: 2)
            }
    }
}

struct ElegantTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Some cool text", text: .constant(""))
            .textFieldStyle(ElegantTextFieldStyle())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
