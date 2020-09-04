//
//  ApiNetworking.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 07/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class NWService: GenericFetchable {
   
    static var shared = NWService()
    
    let session: URLSession
    
   public var pipeline = ImagePipeline.shared
    
    init(config:URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init(){
        self.init(config: .default)
    }
    
    
    
    func loaderAPiCollection(_ inputTuple:(titles:[String], urls:[URL]), completion:@escaping (_ gameLists: [String: (image:String, model:RawgModelGames)] ) -> Void){
        
        var preLoadDictionary = [String: (String, RawgModelGames)]()
        
        let titlesArr = inputTuple.titles
        let urls = inputTuple.urls
        
        let loaderDispatch = DispatchGroup()
        
        for index in 0..<titlesArr.count{
            let urlLink = urls[index]
            loaderDispatch.enter()
            self.getGameListFromCollections(url: urlLink) { (list, _) in
                if let gameList = list{
                    let numberOfgames = gameList.results?.count ?? 1
                    let random = Int.random(in: 1...numberOfgames)
                    if let imageLink = list?.results?[random - 1].backgroundImage {
                        
                        preLoadDictionary[titlesArr[index]] = (imageLink, gameList)
                        loaderDispatch.leave()
                    }
                    
                }
            }
        }
        loaderDispatch.notify(queue: .main){
            completion(preLoadDictionary)
        }
    }
    
    
    func getGameListFromCollections(url: URL, completion:@escaping (_ gameList: RawgModelGames?, _ error: String?) -> Void){
        getData(at: url) { (data, _) in
            guard let data = data else {
                completion(nil, nil)
                return }
            
            do{
                let objectResponse = try JSONDecoder().decode(RawgModelGames.self, from: data)
                completion(objectResponse, nil)
            }catch let jsonSerialization{
                print("error: \(jsonSerialization.localizedDescription)")
            }
        }
    }
    
    
    
    
    
    func getData(at URL: URL, completion:@escaping (_ data:Data?, _ error:String) -> Void ){
        let request = URLRequest(url: URL)
        
        let dataSession = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, "\(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("status code: \(response.statusCode)")
                    completion(data, "\(error.debugDescription)")
                }
            }
        }
        dataSession.resume()
    }
    
    
    
    
    func getGameList(_ date:QueryByDate, completion:@escaping (RawgModelGames?, Error?) -> Void){

        guard let url = URLbuilder.shared.endPointsWithQuery(.games, .dates, date.rawValue) else {fatalError()}
    
        fetch(with: url, decode: { (decodedJson) -> RawgModelGames? in
            guard let gamesList = decodedJson as? RawgModelGames else {return nil}
            return gamesList
        }, completionHandler: completion)
    }
    
    func getGamePlatform(_ completion:@escaping (GamePlatformModel?,Error?) -> Void){
        guard let URLs = URLbuilder.shared.endPointsBuilder(.platforms) else { return }
        fetch(with: URLs, decode: { (decodedJson) -> GamePlatformModel? in
            guard let gamesList = decodedJson as? GamePlatformModel else {return nil}
            return gamesList
        }, completionHandler: completion)
    }
    
    func getAnotheGameList(_ URLs: URL, completion:@escaping (RawgModelGames?,Error?) -> Void){
        let task = URLSession.shared.dataTask(with: URLs) { (data, response, error) in
            guard let validData = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let responseObject = try decoder.decode(RawgModelGames.self, from: validData)
                DispatchQueue.main.async {
                 completion(responseObject, nil)
                }
                
            }catch {
                 DispatchQueue.main.async {
                    completion(nil, error)
                    }
            }
        }
        task.resume()
     }
    
    func getGenreTag(completion:@escaping (RawGenreModel?,Error?) -> Void) {
        guard let url = URLbuilder.shared.endPointsBuilder(.genres) else { fatalError() }
        fetch(with: url, decode: { (genre) -> RawGenreModel? in
            guard let genre = genre as? RawGenreModel else { return nil }
            return genre
        }, completionHandler: completion)
    }
    
    func getPlatformList(_ id:String, completion:@escaping (RawgModelGames?, Error?) -> Void){
         guard let URLrequest = URLbuilder.shared.endPointsWithQuery(.games, .platforms, id) else { return }
         
         fetch(with: URLrequest, decode: { (platform) -> RawgModelGames? in
             guard let platformList = platform as? RawgModelGames else { return nil}
             return platformList
         }, completionHandler: completion)
     }
    
    func getGenreTagList(_ genre:String, completion:@escaping (RawgModelGames?, Error?) -> Void){
        guard let URLrequest = URLbuilder.shared.endPointsWithQuery(.games, .genres, genre) else {return}
        
        fetch(with: URLrequest, decode: { (genre) -> RawgModelGames? in
            guard let genreList = genre as? RawgModelGames else { return nil }
            return genreList
        }, completionHandler: completion)
    }
    
    func getGameDescription(_ gameId:Int, completion:@escaping (RawgGamesDescription?, Error?) -> Void){
        guard let descriptionURL = URLbuilder.shared.endPointsBuilder(.games)?.appendingPathComponent("/\(gameId)") else { fatalError() }
        fetch(with: descriptionURL, decode: { (description) -> RawgGamesDescription? in
            guard let gameDescription = description as? RawgGamesDescription else { return nil }
            return gameDescription
        }, completionHandler: completion)
    }
    
    func getSearchGetList(_ query: String, completion:@escaping (RawgModelGames?,Error?) -> Void ) -> URLSessionDataTask{
        
        guard let searchURL = URLbuilder.shared.endPointsWithQuery(.games, .search, query) else { fatalError("URL invalid to parse") }
        print(searchURL)
        let task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let responseObject = try decoder.decode(RawgModelGames.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }catch let err{
                DispatchQueue.main.async {
                     completion(nil, err)
                }
            }
        }
        task.resume()
        
        return task
    }
    
    func imageRequest(_ URL: URL) -> ImageRequest {
        return ImageRequest(url: URL, processors: [ImageProcessors.Resize.init(size: CGSize(width:320, height: 480))])
    }
       
    
    func makeImageLoadingOptions() -> ImageLoadingOptions {
        return ImageLoadingOptions(
            placeholder: UIImage(named: "placeholder"), transition: .fadeIn(duration: 0.40, options: .curveEaseIn), failureImage: UIImage(named: "failureImage"),contentModes: .init(success: .scaleAspectFill, failure: .center, placeholder: .center))
    }
    
    
    func downloadImage(_ image:String,_ imageView: UIImageView ) {
        guard let imageURL = URL(string: image) else { return }
        let validImageRequest = imageRequest(imageURL)
        var option = makeImageLoadingOptions()
        option.pipeline = self.pipeline
        loadImage(with: validImageRequest, options: option, into: imageView)
    }
    
    func downloadImageIndirectlyToShow(at path:String, completion:@escaping (Data?)-> Void){
        guard let imageURL = URL(string: path) else { return }
        let validImageRequest = imageRequest(imageURL)
        var option = makeImageLoadingOptions()
        option.pipeline = self.pipeline
        pipeline.loadImage(with: validImageRequest, progress: { (_, completed, total) in
            print("download in progress")
        }) { (result) in
            switch result{
            case .failure(.processingFailed):
                fatalError("failed processing")
            case .failure(.dataLoadingFailed(_)):
                fatalError("dataLoadingFailed")
            case .failure(.decodingFailed):
                fatalError("decodingFailed")
            case .success(let data):
                if let data = data.container.data {
                    completion(data)
                }
                
            }
        }
    }
    
    
    func downloadImageURL(_ imgURL:String, _ completion:@escaping (Data) -> Void){
        guard let urls = URL(string: imgURL) else { return }
        
        let task = URLSession.shared.dataTask(with: urls) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
        task.resume()
    }


    }
    
  
    

