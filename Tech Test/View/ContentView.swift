//
//  ContentView.swift
//  Tech Test
//
//  Created by Admin on 20.08.2024.
//


import SwiftUI

enum PopulationType {
    case nation
    case state
}

struct ContentView: View {
    @State private var selectedType: PopulationType = .nation
    
    var body: some View {
        VStack {
            Text("Population Data USA")
                .font(.title)
                .foregroundColor(.blue)
            Picker("Select List", selection: $selectedType) {
                    Text("Nation List").tag(PopulationType.nation)
                    Text("State List").tag(PopulationType.state)
                   }
                   .pickerStyle(SegmentedPickerStyle())
                   .accessibilityIdentifier("populationDataPicker")
                   .padding()
            
            if selectedType == .nation {
                NationListView()        .accessibilityIdentifier("nationListView")
            } else if selectedType == .state {
                StateListView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
