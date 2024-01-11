//
//  BookListCard.swift
//  BookarooPlus
//
//  Created by User on 11.01.2024.
//

import SwiftUI

struct BookListCard: View {
    
    var book: Book
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(book.title ?? "Book title unknown")
                    .font(.headline)
                Text(book.author ?? "Book author unknown")
                    .font(.subheadline)
            }
            Spacer()
            Text("IMG")
        }
    }
}

//#Preview {
//    BookListCard(book: Book(id: "1", isbn: "random isbn", library: "moje knihovna", author: "Peter Pan", title: "How I learnt to fly lol", subtitle: "What is a subtitle", pages: 118, cover: "picture link ig", description: "This is actually a book believe it or not", publisher: "Random publishings inc.", published: "2024-01-11"))
//}
