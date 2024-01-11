//
//  LibrariesView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 08.01.2024.
//

import SwiftUI

struct ListOfLibrariesView: View {
    
    @ObservedObject var viewModel = ListOfLibrariesViewModel()
    
    var body: some View {
        VStack {
            if (viewModel.isLoading) {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.libraries!) { lib in
                        Text(lib.name!)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchLibraries()
        }
    }
}
