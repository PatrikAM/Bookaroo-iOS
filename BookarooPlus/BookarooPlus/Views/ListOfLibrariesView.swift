//
//  LibrariesView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 08.01.2024.
//

import SwiftUI
import Charts

struct ListOfLibrariesView: View {
    
    @ObservedObject var viewModel = ListOfLibrariesViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if (viewModel.isLoading) {
                    ProgressView()
                        .progressViewStyle(.circular)
                    // TODO: separate localized views for error handling from viewmodel error message
                } else {
                    ForEach(viewModel.libraries!) { lib in
                        VStack {
                            Text(lib.name!.capitalizeEachWord())
                                .font(.largeTitle)
                                .bold()
                            var l = [Library(id: "fv", favourite: lib.favourite!), Library(id: "total", favourite: lib.total! - lib.favourite!)]
                            VStack {
                                Chart (l) { sector in
                                    SectorMark(
                                        angle: .value(Text(verbatim:"Value"), sector.favourite!),
                                        innerRadius: .ratio(0.6),
                                        //                                                                outerRadius: .inset(10),
                                        angularInset: 4
                                    )
                                    .cornerRadius(4)
                                    .foregroundStyle(sector.id == "fv" ? Color.blue : Color.red)
                                }
                            }
                            .frame(maxWidth:100)
                        }
                        
                        Spacer()
                            .frame(height: 30)
                        
                        ProgressView(value: Float(lib.read!) / Float(lib.total!),
                                     label: { Text("Keep reading!") },
                                     currentValueLabel: { Text("\(Float(lib.read!) / Float(lib.total!) *   100, specifier: "%.2f")%") })
                        .progressViewStyle(ProgressBarStyle(height: 50))
                        .frame(height: 60)
                        
                        Spacer()
                            .frame(height: 40)
                        
                        if lib != viewModel.libraries!.last {
                            Divider()
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
            }
            .padding(.all)
        }
        .onAppear {
            viewModel.fetchLibraries()
        }
    }
}
