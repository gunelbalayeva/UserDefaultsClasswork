//
//  Model.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import Foundation
struct Model {
    
    struct Character: Codable {
        let id: Int
        let name: String
        let relatives: [String]
        let wikiUrl: String
        let image: String
        let gender: String
        let hair: String
        let occupation: String
        let allOccupations: [String]
        let firstEpisode: String
        let voicedBy: String
        let url: String
    }
}
