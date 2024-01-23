//
//  BookDetailView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import AlertToast
import SwiftUI

struct BookDetailView: View {
    
    var onReadButtonClick: (String) -> Void = { _ in }
    var onFavButtonClick: (String) -> Void = { _ in }
    var onDisappearEvent: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var scannerViewDefault = false
    
    @Binding var deletedId: String?
    
    var bookId: String
    
    var isRecommendation: Bool = false
    
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
                                onHeartClick: {
                                    onFavButtonClick(bookId)
                                    presentationMode.wrappedValue.dismiss()
                                },
                                onBookClick: {
                                    onReadButtonClick(bookId)
                                    presentationMode.wrappedValue.dismiss()
                                },
                                showActions: !isRecommendation
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
                            .padding(.horizontal)
                            Divider()
                            
                            HStack {
                                Text("Title")
                                Spacer()
                                Text("\(viewModel.book?.title ?? "unknown")")
                            }
                            .padding(.horizontal)
                            Divider()
                            
                            HStack {
                                Text("Subtitle")
                                Spacer()
                                if let subtitle = viewModel.book?.subtitle {
                                    Text("\(subtitle)")
                                } else {
                                    Text("unknown")
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                            
                            HStack {
                                Text("Pages")
                                Spacer()
                                if let pages = viewModel.book?.pages {
                                    Text("\(pages)")
                                } else {
                                    Text("unknown")
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                            
                            HStack {
                                Text("ISBN")
                                Spacer()
                                if let isbn = viewModel.book?.isbn {
                                    Text("\(isbn)")
                                } else {
                                    Text("unknown")
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                            
                            HStack {
                                Text("Published")
                                Spacer()
                                if let published = viewModel.book?.published {
                                    Text("\(published)")
                                } else {
                                    Text("unknown")
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                            
                            HStack {
                                Text("Publisher")
                                Spacer()
                                if let publisher = viewModel.book?.publisher {
                                    Text("\(publisher)")
                                } else {
                                    Text("unknown")
                                }
                                
                                
                            }
                            .padding(.horizontal)
                            Divider()
                            
                            if !isRecommendation {
                                HStack {
                                    Button(action: {
                                        viewModel.deleteBook(bookId: bookId)
                                    }) {
                                        Text("Delete")
                                    }
                                    .buttonStyle(.borderedProminent)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        editing = true
                                    }) {
                                        Text("Edit")
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                                .padding(.horizontal, 15)
                                
                            }
                        }
                    }
                    
                    .navigationDestination(isPresented: $editing) {
                        if viewModel.book != nil {
                            BookAddEditView(onDisappearEvent: onDisappearEvent, isScannerViewActive: $scannerViewDefault, book: viewModel.book!)
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
                        print("on appear")
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
