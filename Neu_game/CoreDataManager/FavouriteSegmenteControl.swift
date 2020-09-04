//
//  FavouriteSegmenteControl.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 29/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation

enum Favorites {
    case segmentCells

    struct FavoritesSegments {
        let segmentsCells = ["favourite", "played", "best", "deleted"]
    }

    var data: [String] {
        switch self {
        case .segmentCells:
            return FavoritesSegments().segmentsCells
        default:
            break
        }
    }
}
