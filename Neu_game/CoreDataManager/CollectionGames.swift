//
//  CollectionGames.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 29/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation


struct CollectionGames {
    let name:String
    let image:String
    let note:String
    let rating:Int
    let lastStage:String
    
    
    init(name:String, image:String, note:String, rating:Int, lastStage:String) {
        self.name = name
        self.image = image
        self.note = note
        self.rating = rating
        self.lastStage = lastStage
    }
}
