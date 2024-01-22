//
//  BookDetailView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import AlertToast
import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var deletedId: String?
    
    var bookId: String
    
    @ObservedObject var viewModel = BookViewModel()
    
    @State private var editing = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    if let _ = viewModel.book?.cover {
                        if let image = viewModel.coverImage {
                            //                        Color(image.averageColor!)
                            //                        //                        .frame(height: 100, alignment: .top)
                            //                            .edgesIgnoringSafeArea(.top)
                            Rectangle()
                                .fill(Color(image.averageColor!))
                                .frame(width: geometry.size.width * 1.4, height: geometry.size.height * 0.2)
                                .position(x: geometry.size.width / 2.35, y: geometry.size.height * 0.1)
                                .edgesIgnoringSafeArea(.all)
                            
                        }
                        
                    }
                    
                    VStack(alignment: .center) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else if viewModel.book != nil {
                            BookCard(
                                book: viewModel.book!,
                                color: Color(viewModel.coverImage?.averageColor ?? .gray),
                                onHeartClick: { viewModel.book?.favourite?.toggle() },
                                onBookClick: { viewModel.book?.read?.toggle() }
                            )
//                            Text(viewModel.book!.title!)
//                            Text(viewModel.book?.cover ?? "unknown")
//                            Text(viewModel.book?.isbn ?? "")
//                            if let image = viewModel.book?.cover {
//                                if let image = viewModel.coverImage {
//                                    Circle()
//                                        .foregroundColor(Color(image.averageColor!))
//                                }
//                                
//                            }
                            
                            Spacer()
                            
                            HStack {
                                Text("Author")
                                Spacer()
                                Text("\(viewModel.book?.author ?? "unknown")")
                            }
                            Divider()
                            
                            HStack {
                                Text("Title")
                                Spacer()
                                Text("\(viewModel.book?.title ?? "unknown")")
                            }
                            Divider()
                            
                            HStack {
                                Text("Subtitle")
                                Spacer()
                                Text("\(viewModel.book?.subtitle ?? "unknown")")
                            }
                            Divider()
                            
                            HStack {
                                Text("Pages")
                                Spacer()
                                Text("\(viewModel.book?.pages ?? 0)")
                            }
                            Divider()
                            
                            HStack {
                                Text("ISBN")
                                Spacer()
                                Text("\(viewModel.book?.isbn ?? "unknown")")
                            }
                            Divider()
                            
                            HStack {
                                Text("Published")
                                Spacer()
                                Text("\(viewModel.book?.published ?? "unknown")")
                            }
                            Divider()
                            
                            HStack {
                                Text("Publisher")
                                Spacer()
                                Text("\(viewModel.book?.publisher ?? "unknown")")
                            }
                            Divider()
                            
                            Button(action: {
                                viewModel.deleteBook(bookId: bookId)
                            }) {
                                Text("Delete")
                            }
                            
                            Button(action: {
                                editing = true
                            }) {
                                Text("Edit")
                            }
                        }
                    }
                    
                    .navigationDestination(isPresented: $editing) {
                        if viewModel.book != nil {
                            BookAddEditView(book: viewModel.book!)
                        }
                    }
                    .toast(isPresenting: $viewModel.showError) {
                        AlertToast(
                            displayMode: .alert,
                            type: .error(Color.red),
                            subTitle: viewModel.errorMessage
                        )
                    }
                    .onAppear {
                        viewModel.fetchBook(bookId: bookId)
                    }
                    .onChange(of: viewModel.deletionDone) {
                        deletedId = bookId
                        presentationMode.wrappedValue.dismiss()
                    }
                    .toolbar(.hidden, for: .tabBar)
                }
            }
        }
    }
}
