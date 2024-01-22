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
        // TODO: create error view with separate error states for all viewmodels and retry button with callback
        VStack {
            if (viewModel.isLoading) {
                ProgressView()
            } else {
                ScrollView {
                    ForEach(viewModel.readers!) { reader in
                        ReaderContactCard(reader: reader)
                    }
                }
                .scrollIndicators(.visible)
            }
        }
        .onAppear {
            viewModel.fetchReaders()
        }
    }
}
