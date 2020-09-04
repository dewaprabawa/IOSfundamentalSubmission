//
//  GameDescriptionModel.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 07/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation

struct RawgGamesDescription:Codable {
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case descriptionRaw = "description_raw"
    }
}
