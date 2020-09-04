//
//  GamePlatformModel.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 17/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit

struct GamePlatformModel: Codable {
    
       let count: Int?
       let next: String?
       let results: [Platforms]?
       
       enum CodingKeys: String, CodingKey{
           case count
           case next
           case results
       }
}


struct Platforms: Codable {
    
    let id: Int?
    let slug: String?
    let name: String?
    let backgroundImage: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case backgroundImage = "image_background"
    }
    
}
