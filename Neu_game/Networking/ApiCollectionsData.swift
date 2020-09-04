//
//  ApiGenreCollections.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 05/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class ApiCollectionsData {
    
    static var shared = ApiCollectionsData()
    
    func collectionGenreListApi() -> (titles:[String], urls:[URL]){
        
        let actionTitle = "action"
        guard let actionURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, actionTitle) else { fatalError("failed fetch api") }
        
        
        let indieTitle = "indie"
        guard let indieURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, indieTitle) else { fatalError("failed fetch api") }
        
        let adventureTitle = "adventure"
        guard let adventureURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, adventureTitle) else { fatalError("failed fetch api") }
        
        let rpgTitle = "role-playing-games-rpg"
        guard let rpgURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, rpgTitle) else { fatalError("failed fetch api")  }
        
        let strategyTitle = "strategy"
        guard let strategyURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, strategyTitle) else { fatalError("failed fetch api") }
        
        
        let shooterTitle = "shooter"
        guard let shooterURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, shooterTitle) else { fatalError("failed fetch api") }
        
        let casualTitle = "casual"
        guard let casualURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, casualTitle) else { fatalError("failed fetch api") }
        
        let simulationTitle = "simulation"
        guard let simulationURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, simulationTitle) else {  fatalError("failed fetch api")  }
        
        
        let puzzleTitle = "puzzle"
        guard let puzzleURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, puzzleTitle) else { fatalError("failed fetch api") }
        
        let arcadeTitle = "arcade"
        guard let arcadeURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, arcadeTitle) else { fatalError("failed fetch api") }
        
        let platformerTitle = "platformer"
        guard let platformerURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, platformerTitle) else { fatalError("failed fetch api") }
        
        let racingTitle = "racing"
        guard let racingURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, racingTitle) else {fatalError("failed fetch api")}
        
        let sportsTitle = "sports"
        guard let sportsURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, sportsTitle) else {fatalError("failed fetch api") }
        
        let massively_multiplayerTitle = "massively-multiplayer"
        guard let massively_multiplayerURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, massively_multiplayerTitle) else {fatalError("failed fetch api") }
        
        
        let familyTitle = "family"
        guard let familyURL =  URLbuilder.shared.endPointsWithQuery(.games, .genres, familyTitle) else { fatalError("failed fetch api") }
        
        let fightingTitle = "fighting"
        guard let fightingURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, fightingTitle) else { fatalError("failed fetch api") }
        
        let board_gamesTitle = "board-games"
        guard let board_gamesURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, board_gamesTitle) else { fatalError("failed fetch api") }
        
        let educationalTitle = "educational"
        guard let educationalURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, educationalTitle) else {fatalError("failed fetch api")}
        
        let cardTitle = "card"
        guard let cardURL = URLbuilder.shared.endPointsWithQuery(.games, .genres, cardTitle) else { fatalError("failed fetch api")}
        
        
        let titles = [actionTitle, indieTitle,adventureTitle, rpgTitle, strategyTitle, shooterTitle, casualTitle, simulationTitle,puzzleTitle, arcadeTitle, platformerTitle, racingTitle, sportsTitle, massively_multiplayerTitle, familyTitle,fightingTitle, board_gamesTitle, educationalTitle, cardTitle]
        
        let urls = [actionURL, indieURL,adventureURL, rpgURL, strategyURL, shooterURL, casualURL, simulationURL,puzzleURL, arcadeURL, platformerURL, racingURL, sportsURL, massively_multiplayerURL, familyURL,fightingURL, board_gamesURL, educationalURL, cardURL]
        
        return (titles, urls)
    }
    
    
    
    func collectionPlatformListApi() -> (titles:[String], urls:[URL]){
        let pcTitle = "PC"
        guard let pcURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "4") else {fatalError("failed fetch api")}
        
        
        let playstation5Title = "PlayStation 5"
        guard let playstation5URL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "187") else {fatalError("failed fetch api")}
        
        let xbox_oneTitle = "Xbox One"
        guard let xbox_oneURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "1") else {fatalError("failed fetch api")}
        
        let playstation4Title = "PlayStation 4"
        guard let playstation4URL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "18") else {fatalError("failed fetch api")}
        
        
        let xbox_series_xTitle = "Xbox Series X"
        guard let xbox_series_xURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "186") else { fatalError("failed fetch api") }
        
        let nintendo_switchTitle = "Nintendo Switch"
        guard let nintendo_switchURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "7") else {fatalError("failed fetch api")}
        
        
        let iosTitle = "iOS"
        guard let iosURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "3") else { fatalError("failed fetch api") }
        
        
        let androidTitle = "Android"
        guard let androidURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "21") else { fatalError("failed fetch api") }
        
        let nintendo_3dsTitle = "Nintendo 3DS"
        guard let nintendo_3dsURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "8") else { fatalError("failed fetch api") }
        
        let nintendo_dsTitle = "Nintendo DS"
        guard let nintendo_dsURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "9") else {fatalError("failed fetch api")}
        
        let nintendo_dsiTitle = "Nintendo DSi"
        guard let nintendo_dsiURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "13") else {fatalError("failed fetch api")}
        
        let macosTitle = "macOS"
        guard let macosURL = URLbuilder.shared.endPointsWithQuery(.games, .platforms, "5") else {fatalError("failed fetch api")}
        
        
        
        let titles = [pcTitle, playstation5Title, xbox_oneTitle, playstation4Title, xbox_series_xTitle, nintendo_switchTitle, iosTitle, androidTitle, nintendo_3dsTitle, nintendo_dsTitle, nintendo_dsiTitle, macosTitle]
        let urls = [pcURL, playstation5URL, xbox_oneURL, playstation4URL,xbox_series_xURL, nintendo_switchURL, iosURL,androidURL, nintendo_3dsURL, nintendo_dsURL, nintendo_dsiURL, macosURL]
        
        return (titles,urls)
    }
    
    
    
    
}
