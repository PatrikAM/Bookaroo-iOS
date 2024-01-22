//
//  ReaderContactCard.swift
//  BookarooPlus
//
//  Created by Marek Glas on 22.01.2024.
//

import SwiftUI

struct ReaderContactCard: View {
    
    var reader: Reader
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(reader.name?.capitalizeEachWord() ?? "Name not available")
                    .font(.title)
                Text(reader.login ?? "Login not available")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    ReaderContactCard(reader: Reader(id: "random id", name: "John Doe", login: "john.doe@doemail.com", token: "some token"))
}
