//
//  BookCard.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 22.01.2024.
//

import SwiftUI

struct BookCard: View {
    
    var book: Book
    
    let color: Color
    
    var onHeartClick: () -> Void
    var onBookClick: () -> Void
    
    var showActions: Bool = true
    
    let bookPlaceHolderImage = "https://www.marytribble.com/wp-content/uploads/2020/12/book-cover-placeholder.png"

    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                .fill(color)
                .shadow(radius: 5)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, idealHeight: 250, maxHeight: 250)
            
            ZStack(alignment: .top) {
                HStack(alignment: .top) {
                    if showActions {
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
                        .frame(width: 100, height: 350)
                        Spacer()
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
                        .frame(width: 100, height: 350)
                    }
                }
                VStack {
                    VStack(alignment: .center) {
                        Text(book.title ?? "Book title unknown")
                            .font(.title3)
                        Text(book.author ?? "Book author unknown")
                            .font(.subheadline)
                        Text("Pages: \(book.pages ?? 0)")
                            .font(.subheadline)
                    }
//                    .padding(.top)
                    //                Spacer()
                    HStack {
                        Spacer()
                        if book.cover != nil && book.cover!.isValidUrl() {
                            AsyncImage(url: URL(string: book.cover!)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 300)
                            .clipped()
                            Spacer()
                        } else {
                            AsyncImage(url: URL(string: bookPlaceHolderImage)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 300)
                            .clipped()
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 400)
        .background()
        
    }
}
