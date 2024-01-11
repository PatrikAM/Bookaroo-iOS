//
//  BookDetailView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import SwiftUI

struct BookDetailView: View {
    
    let bookId: String
    
    @ObservedObject var viewModel = BookViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text(viewModel.book!.title!)
                Text(viewModel.book?.cover ?? "unknown")
                if let image = viewModel.book?.cover {
                    if let image = viewModel.coverImage {
                        Circle()
//                            .foregroundColor(UIImage(image)?)
                            .foregroundColor(Color(image.averageColor!))
                    }
//                    ZStack {
//                        AsyncImage(url: URL(string: image))
//                    }
//                        .frame(width: 10, height: 10)
                }
                Text("TODO: info o knize")
            }
        }
        .onAppear {
            viewModel.fetchBook(bookId: bookId)
        }
    }
}
