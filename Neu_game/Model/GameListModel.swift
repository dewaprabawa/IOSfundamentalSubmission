//
//  GameList.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 07/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation


struct RawgModelGames: Codable {
    
    let count: Int?
    let next: String?
    let results: [RawgContents]?
    
    enum CodingKeys: String, CodingKey{
        
        case count
        case next
        case results
    }
}

struct RawgContents: Codable {
    
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let clip: RawgVideo?
    let screenshots: [RawgShortScreenShot]?
    let platformGame:[PlatformGames]?
    let genreGames:[GenreGames]?
    let stores:[Stores]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case released = "released"
        case backgroundImage = "background_image"
        case rating = "rating"
        case clip = "clip"
        case screenshots = "short_screenshots"
        case platformGame = "platforms"
        case genreGames = "genres"
        case stores = "stores"
    }
}


struct Stores: Codable {
    let url_en: URL?
    
    enum CodingKeys: String, CodingKey {
        case url_en = "url_en"
    }
}


struct GenreGames: Codable {
    let name: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}


struct PlatformGames: Codable {
    let platform: PLatformName?
    
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

struct PLatformName:Codable{
    let name:String
}

struct RawgShortScreenShot: Codable {
    let id: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case image
    }
}


struct RawgVideo: Codable {
    
    let clips: RawgVideos?
    
    let preview: String?
    
    enum CodingKeys: String, CodingKey{
        case clips
        case preview
    }
}

struct RawgVideos: Codable {
    let full: String?
    
    enum Codingkeys: String, CodingKey{
        case full
    }
}
