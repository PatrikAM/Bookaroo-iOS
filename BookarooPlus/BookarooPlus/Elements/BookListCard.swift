//
//  BookListCard.swift
//  BookarooPlus
//
//  Created by Marek Glas on 11.01.2024.
//

import SwiftUI

struct BookListCard: View {
    
    var book: Book
    
    var onHeartClick: () -> ()
    var onBookClick: () -> ()
    
    let bookPlaceHolderImage = "https://www.marytribble.com/wp-content/uploads/2020/12/book-cover-placeholder.png"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                .fill(Color.cyan)
                .shadow(radius: 5)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, idealHeight: 450, maxHeight: 450)
            
            VStack {
                HStack {
                    Spacer()
                    if book.cover != nil && book.cover!.isValidUrl() {
                        AsyncImage(url: URL(string: book.cover!)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 400)
                        .clipped()
                        Spacer()
                    } else {
                        AsyncImage(url: URL(string: bookPlaceHolderImage)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 400)
                        .clipped()
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                VStack(alignment: .center) {
                    Text(book.title ?? "Book title unknown")
                        .font(.title3)
                    Text(book.author ?? "Book author unknown")
                        .font(.subheadline)
                    Text("Pages: \(book.pages ?? 0)")
                        .font(.subheadline)
                    HStack {
                        Button(action: {
                            onBookClick()
                        }) {
                            Image(systemName: "book.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(self.book.read ?? false ? .indigo : .white)
                                .backgroundStyle(.brown)
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 100, height: 100)
                        Spacer()
                        Button(action: {
                            onHeartClick()
                        }) {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(self.book.favourite ?? false ? .red : .white)
                                .backgroundStyle(.brown)
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 100, height: 100)
                    }
                }
                
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
