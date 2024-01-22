//
//  ListOfReadersView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 08.01.2024.
//

import SwiftUI

struct ListOfReadersView: View {
    
    @ObservedObject var viewModel = ListOfReadersViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if (viewModel.isLoading) {
                    ProgressView()
                } else if (viewModel.errorMessage != nil) {
                    ErrorView(onRetryButtonClick: viewModel.fetchReaders, errorMessageIdentifier: viewModel.errorMessage!)
                } else {
                    ScrollView {
                        ForEach(viewModel.readers!) { reader in
                            ReaderContactCard(reader: reader)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                        }
                    }
//                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scrollIndicators(.visible)
                }
            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
            .padding(.all)
        }
        .onAppear {
            viewModel.fetchReaders()
        }
    }
}
