//
//  StateListView.swift
//  Tech Test
//
//  Created by Admin on 20.08.2024.
//

import SwiftUI

struct StateListView: View {
    @ObservedObject var viewModel = PopulationDataViewModel()

    var body: some View {
        if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
        }
        List(viewModel.stateData) { entry in
            VStack(alignment: .leading) {
                Text(entry.state).font(.title)
                HStack {
                    Text("Year: ").font(.headline)
                    Text(entry.year).font(.subheadline)
                }
                HStack {
                    Text("Population: ").font(.headline)
                    Text("\(entry.population)").font(.subheadline)
                }
            }
        }.onAppear {
            viewModel.fetchData(populationType: .state)
        }
        .navigationTitle("State List")
    }
}
