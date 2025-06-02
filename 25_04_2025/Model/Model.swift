//
//  Model.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import Foundation
struct Relative: Codable {
    let name: String
}

struct Model: Codable {
    let id: Int
    let name: String
    let image: String
    let gender: String?
    let hairColor: String?
    let age: String?
    let allOccupations: [String]
    let occupation: String?
    let nicknames: [String]
    let relatives: [Relative]
    let firstEpisode: String?
    let voicedBy: String?
    let wikiUrl: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
           case id, name, image, gender, hairColor, age, allOccupations, occupation, nicknames, relatives, firstEpisode, voicedBy, wikiUrl, url
       }
}
