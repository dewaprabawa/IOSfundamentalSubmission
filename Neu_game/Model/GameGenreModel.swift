//
//  GamGenreModel.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 12/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation



struct RawGenreModel: Codable{
    let results: [GameGenre]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct GameGenre: Codable {
    
    let id: Int?
    let name: String?
    let slug: String?
    let backgroundImage: String?
    let games: [Games]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case backgroundImage = "image_background"
        case games = "games"
    }
}


struct Games: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
