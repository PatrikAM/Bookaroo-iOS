//
//  BookarooTextfield.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 17.01.2024.
//

import SwiftUI

struct BookarooTextfield: View {
    
    let label: String
    @Binding var value: String
    
    var body: some View {
        TextField(
            label,
            text: $value
        )
        .textFieldStyle(ElegantTextFieldStyle())
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .padding(.top, 20)
    }
}
