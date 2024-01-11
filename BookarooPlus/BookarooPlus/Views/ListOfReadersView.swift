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
        VStack {
            if (viewModel.isLoading) {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.readers!) { reader in
                        Text(reader.login!)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchReaders()
        }
    }
}
