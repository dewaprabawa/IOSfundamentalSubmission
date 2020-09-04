//
//  ApiURLConfigure.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 07/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation

class URLbuilder {
    
    static var shared = URLbuilder()

    
    enum EndPoints:String{
        
        case games = "/games"
        case platforms = "/platforms"
        case genres = "/genres"
        case creators = "/creators"
        case developers = "/developers"
        case publishers = "/publishers"
        case stores = "/stores"
    }
    
    enum QueryParameters:String {
        case search
        case platforms
        case stores
        case developers
        case publishers
        case genres
        case creators
        case dates
        case page
        case pageSize = "page_size"
        case ordering
    }
    
    enum UGCaller {
        
        case url(_ path:EndPoints)
        
        case urlWithQuery(_ path:EndPoints,_ qParams:QueryParameters,_ value:String)
     }
    
    func URLComposser(_ url: UGCaller) -> URL? {
        
        var URL: URL? {
            switch url {
            case .url(let path):
               return  self.endPointsBuilder(path)
            case .urlWithQuery(let path, let qParams, let value):
                return self.endPointsWithQuery(path, qParams, value)
            }
        }
        
        guard let validURL = URL else {fatalError("Could not produce URL")}
        
        return validURL
    }
    
    
    
    func endPointsBuilder(_ path: EndPoints) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.rawg.io"
        urlComponents.path = "/api" + path.rawValue
        return urlComponents.url
        
    }
    
    func endPointsWithQuery(_ path: EndPoints, _ qParams:QueryParameters, _ value:String) -> URL? {
           
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.rawg.io"
        urlComponents.path = "/api" + path.rawValue
        urlComponents.queryItems = [URLQueryItem(name: qParams.rawValue, value: value)]
        return urlComponents.url
    
    }

}



public enum QueryByDate: String {
    
    case latest = "2019-12-10,2020-10-10"
    
    case classic = "1990-01-01,1999-12-31"
    
}
