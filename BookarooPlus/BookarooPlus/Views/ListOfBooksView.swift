//
//  ListOfBooksView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 05.01.2024.
//

import SwiftUI

struct ListOfBooksView: View {
    
    @ObservedObject var booksViewModel = ListOfBooksViewModel()
    @ObservedObject var librariesViewModel = ListOfLibrariesViewModel()
    @ObservedObject var authManager: AuthManager = .init()
    //    @Environment(\.presentationMode) var presentationMode
    @Binding var isLoggedOut: Bool
    
    @State var selectionChange = false
    @State private var selectedBook: String?
    
    @State var deletedId: String? = nil
    @State var showScanningDialog: Bool = false
    @State var showScanner: Bool = false
    @State var navigateToBookAdd: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if booksViewModel.isLoading {
                    ProgressView()
                } else if (booksViewModel.errorMessage != nil) {
                    ErrorView(onRetryButtonClick: booksViewModel.fetchBooks, errorMessageIdentifier: booksViewModel.errorMessage!)
                } else if booksViewModel.books != nil {
//                    Text("Hint: Use the plus button to add a new book")
//                        .font(.subheadline)
//                        .padding(.all)
                    VStack {
                        if librariesViewModel.libraries != nil {
                            VStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(librariesViewModel.libraries!.indices) { index in
                                            //                                Text(library.name!)
                                            Chip(
                                                titleKey: librariesViewModel.libraries![index].name!,
                                                isSelected: librariesViewModel.libraries![index].isSelected!,
                                                selectionChanges: $selectionChange
                                            ) {
                                                librariesViewModel.libraries![index].isSelected?.toggle()
                                            }
                                            .padding(.trailing, 10)
                                        }
                                    }
                                    .padding(10)
                                    
                                }
                                
                            }
                        }
                        GeometryReader { geometry in
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 0) {
                                    //                    BookListCard(book: booksViewModel.filteredBooks!.first!)
                                    ForEach(booksViewModel.filteredBooks!, id: \.id) { book in
                                        BookListCard(
                                            book: book,
                                            onHeartClick: { booksViewModel.toggleFavourite(bookId: book.id!) },
                                            onBookClick: { booksViewModel.toggleRead(bookId: book.id!) }
                                        )
                                        .onTapGesture {
                                            selectedBook = book.id!
                                            print("Book tapped: \(book.id!)")
                                        }
                                        .padding(.all)
                                        .ignoresSafeArea(edges: .horizontal)
                                        .frame(width: geometry.size.width)
                                    }
                                }
                                .navigationDestination(item: $selectedBook) { bookId in
                                    BookDetailView(
                                        onReadButtonClick: booksViewModel.toggleRead,
                                        onFavButtonClick: booksViewModel.toggleFavourite,
                                        onDisappearEvent: booksViewModel.fetchBooks,
                                        deletedId: $deletedId,
                                        bookId: bookId
                                    )
                                    
                                    .onDisappear {
                                        selectedBook = nil
                                    }
                                }
                            }
                            .frame(width: geometry.size.width)
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .safeAreaPadding(.horizontal)
                        
                    }
                    
                } else {
                    Text(booksViewModel.errorMessage!)
                }
                
            }
            .navigationDestination(isPresented: $navigateToBookAdd) {
                BookAddEditView(
                    onDisappearEvent: booksViewModel.fetchBooks)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showScanningDialog.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
        .onAppear {
            booksViewModel.fetchBooks()
            librariesViewModel.fetchLibraries()
        }
        .onChange(of: selectionChange) {
            if librariesViewModel.libraries!.filter({ $0.isSelected! }).isEmpty {
                booksViewModel.filteredBooks = booksViewModel.books
            } else {
                booksViewModel.filterBooks(libs: librariesViewModel.libraries!.filter { $0.isSelected! })
            }
        }
        .onChange(of: deletedId) {
            booksViewModel.books?.removeAll(where: { book in book.id == deletedId } )
            booksViewModel.filteredBooks?.removeAll(where: { book in book.id == deletedId } )
        }
        // TODO: change dialog header and message to Unit -> needs Text for string catalog to recognise
        .customConfirmDialog(
            isPresented: $showScanningDialog,
            header: Text("isbn_manual_selection_text"),
            message: Text("barcode_scan_help_text")
        ) {
            Button {
                navigateToBookAdd = true
                showScanningDialog.toggle()
            } label: {
                Label("Manually", systemImage: "hand.raised")
            }
            Divider()
            Button {
                showScanner.toggle()
                showScanningDialog.toggle()
            } label: {
                Label("Using ISBN", systemImage: "barcode.viewfinder")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showScanningDialog.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showScanner) {
            BarcodeScannerView(
                onDisappearEvent: booksViewModel.fetchBooks,
                isScannerViewActive: $showScanner
            )
        }
        
        //        .navigate (to: BaseView(), when: $isLoggedOut)
    }
}



