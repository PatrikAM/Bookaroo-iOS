//
//  Chip.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 08.01.2024.
//

import SwiftUI

struct Chip: View {
    
    let systemImage: String = "building.columns.circle"
    let titleKey: String
    @State var isSelected: Bool
    
    
        
    @Binding var selectionChanges: Bool
    
    var onTapGesture: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Image.init(systemName: systemImage).font(.body)
            Text(titleKey.capitalizeEachWord())
                .font(.body)
                .lineLimit(1)
        }
        .padding(.vertical, 6)
        .padding(.leading, 6)
        .padding(.trailing, 12)
        .foregroundColor(isSelected ? .white : .white)
        .background(isSelected ? Color.accentColor : Color("Secondary"))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 0)
        )
        .onTapGesture {
            isSelected.toggle()
            onTapGesture()
            selectionChanges.toggle()
            
        }
    }
}
