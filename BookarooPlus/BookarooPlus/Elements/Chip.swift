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
            Text(titleKey)
                .font(.body)
                .lineLimit(1)
        }
        .padding(.vertical, 4)
        .padding(.leading, 4)
        .padding(.trailing, 10)
        .foregroundColor(isSelected ? .white : .blue)
        .background(isSelected ? Color.blue : Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 1.5)
            
        ).onTapGesture {
            isSelected.toggle()
            onTapGesture()
            selectionChanges.toggle()
            
        }
    }
}
