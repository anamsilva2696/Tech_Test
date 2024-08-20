//
//  PopulationDataViewModel.swift
//  Tech Test
//
//  Created by Admin on 20.08.2024.
//

import Foundation

class PopulationDataViewModel: ObservableObject {
    @Published var nationData: [NationData] = []
    @Published var stateData: [StateData] = []
    @Published var errorMessage: String? = nil
    private var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetchData(populationType: PopulationType) {
        let urlString: String
        
        switch populationType {
        case .nation:
            urlString = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
        case .state:
            urlString = "https://datausa.io/api/data?drilldowns=State&measures=Population&year=latest"
        
        }
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid Url"
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "There is no data"
                }
                return
            }
            
            do {
                switch populationType {
                case .nation:
                    let decodeData = try JSONDecoder().decode(PopulationNation.self, from: data)
                    DispatchQueue.main.async {
                        self.nationData = decodeData.data
                    }
                case .state: 
                    let decodeData = try JSONDecoder().decode(PopulationState.self, from: data)
                    DispatchQueue.main.async {
                        self.stateData = decodeData.data
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding data"
                }
            }
        }
        dataTask.resume()
    }
}
