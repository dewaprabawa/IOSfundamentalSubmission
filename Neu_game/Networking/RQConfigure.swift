//
//  RequestConfigure.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 07/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation

protocol GenericFetchable {
    
    var session:URLSession{ get }
    
    func fetch<T:Decodable>(with url:URL, decode:@escaping (Decodable) -> T?, completionHandler:@escaping (T?, Error?) -> Void)
    
}

extension GenericFetchable {
    
    func dataTask<T:Decodable>(with url: URL, decodingType:T.Type,_ completion:@escaping (Decodable?, Error?) -> Void) -> URLSessionDataTask {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Dewa", forHTTPHeaderField: "User-Agent")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let HTTPResponses = response as? HTTPURLResponse {
                print("\(HTTPResponses.statusCode)")
            }
            
            guard let validData = data, error == nil else{
                completion(nil, error)
                return
            }
            
            do{
        
                let json = try JSONDecoder().decode(decodingType, from: validData)
                completion(json, nil)
            }catch {
                completion(nil, error)
            }
            
        }
        task.resume()
        
        return task
    }
    
    func fetch<T:Decodable>(with url:URL, decode:@escaping (Decodable) -> T?, completionHandler:@escaping (T?, Error?) -> Void){
        
        let task = dataTask(with: url, decodingType: T.self) {(json, error) in
            
            DispatchQueue.main.async {
                
                guard let json = json else {
                    completionHandler(nil,error)
                    return
                }
                
                if let decodedJson = decode(json){
                    completionHandler(decodedJson, nil)
                    
                }else {
                   completionHandler(nil,error)
                }
                
            }
        }
        
        task.resume()
        
    }
}

