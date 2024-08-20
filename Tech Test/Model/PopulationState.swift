//
//  State.swift
//  Tech Test
//
//  Created by Admin on 20.08.2024.
//

import Foundation
struct PopulationState: Codable {
    let data: [StateData]
}

struct StateData: Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    let idState: String
    let state: String
    let idYear: Int
    let year: String
    let population: Int
    let slugState: String
    
    enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
