//
//  BookListCard.swift
//  BookarooPlus
//
//  Created by Marek Glas on 11.01.2024.
//

import SwiftUI

struct BookListCard: View {
    
    var book: Book
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                .fill(Color.cyan)
                .shadow(radius: 5)
                .frame(height: 500)
            
            VStack (alignment: .leading) {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: book.cover ?? "")) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .clipped()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                Text(book.title ?? "Book title unknown")
                    .font(.headline)
                Text(book.author ?? "Book author unknown")
                    .font(.subheadline)
                Spacer()
            }
            Spacer()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background()
        
    }
}

//#Preview {
//    BookListCard(book: Book(id: "1", isbn: "random isbn", library: "moje knihovna", author: "Peter Pan", title: "How I learnt to fly lol", subtitle: "What is a subtitle", pages: 118, cover: "picture link ig", description: "This is actually a book believe it or not", publisher: "Random publishings inc.", published: "2024-01-11"))
//}
