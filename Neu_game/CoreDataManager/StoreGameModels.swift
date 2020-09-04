//
//  StoreGameModels.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 19/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation

struct StoreGameModels: Hashable {
        let gameUuid: UUID
        let gameNoteCreateTime: Double
        let gameId: String
        let gameTitle: String?
        let gameReleased: String
        let gameRating: String
        let gameImageLink: String
        let gameDescription: String?
        let gameScreenshotsLinks: [String?]
        let gameGenre:[String?]
        let gameVideoPreviewImageLink: String?
        let gameVideoLink: String?

        init(gameUuid: UUID = UUID(),
             gameNoteCreateTime: Double = Date().timeIntervalSince1970,
             gameId: String,
             gameTitle: String?,
             gameReleased: String,
             gameRating: String,
             gameImageLink: String,
             gameDescription: String?,
             gameScreenshotsLinks: [String?],
             gameGenre:[String?],
             gameVideoPreviewImageLink: String?,
             gameVideoLink: String?) {
            self.gameUuid = gameUuid
            self.gameNoteCreateTime = gameNoteCreateTime
            self.gameId = gameId
            self.gameTitle = gameTitle
            self.gameReleased = gameReleased
            self.gameRating = gameRating
            self.gameImageLink = gameImageLink
            self.gameDescription = gameDescription
            self.gameScreenshotsLinks = gameScreenshotsLinks
            self.gameGenre = gameGenre
            self.gameVideoPreviewImageLink = gameVideoPreviewImageLink
            self.gameVideoLink = gameVideoLink
        }
}


