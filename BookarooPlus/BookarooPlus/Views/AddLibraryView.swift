//
//  AddLibraryView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 21.01.2024.
//

import SwiftUI

struct AddLibraryView: View {
    
    var onAddButtonClick: (String) -> Void = { _ in }
    
    @Environment(\.dismiss) var dismiss
    
    @State var libraryName = ""
    
    var body: some View {
        VStack {
            Text("Add new library")
                .font(.title)
                .padding(.top)
            
            Spacer()
                .frame(height: 30)
            
            BookarooTextfield(label: "Enter new library name", value: $libraryName)
            Spacer()
            
            Button {
                self.onAddButtonClick(self.libraryName)
                dismiss()
            } label: {
                Text("Add to libraries")
                    .padding(5)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .buttonStyle(.borderedProminent)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.all)
    }
}

#Preview {
    AddLibraryView()
}
