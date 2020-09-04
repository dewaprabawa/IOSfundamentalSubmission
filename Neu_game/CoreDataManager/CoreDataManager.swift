//
//  CoreDataManager.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 19/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//


import CoreData
import UIKit

class CoreDataManager:NSObject, NSFetchedResultsControllerDelegate {
    
    var gamesStoreInCoreData = [StoreGameModels]()
    
    var fetchResultController:NSFetchedResultsController<GameStore>!

    
    
    static var stack = CoreDataManager()
    
    func saveGameWithCore(_ contents: StoreGameModels){
      
            let newgames = GameStore(context: CoreDataStack.shared.managedContext)
            
            newgames.gameUuid = contents.gameUuid
            newgames.gameId = contents.gameId
            newgames.gameRating = contents.gameRating
            newgames.gameReleased = contents.gameReleased
            newgames.gameScreenshotsLinks = contents.gameScreenshotsLinks as? [String] ?? [String]()
            newgames.gameDescription = contents.gameDescription
            newgames.gameImageLink = contents.gameImageLink
            newgames.gameTitle = contents.gameTitle
             newgames.gameGenre = contents.gameGenre as? [String] ?? [String]()
            newgames.gameVideoLink = contents.gameVideoLink
            newgames.gameNoteCreateTime = contents.gameNoteCreateTime
            newgames.gameVideoPreviewImageLink = contents.gameVideoPreviewImageLink
            
            do{
                
            try CoreDataStack.shared.managedContext.save()
            
            print("save core data success")
            }catch let error as NSError{
                
            print("error:\(error) \(error.userInfo)")
                
            }
    }
    
    
    func loadTryDataInDetail(gameId:String, completion: @escaping (_ game: StoreGameModels?) -> Void){
        
      let request:NSFetchRequest<GameStore> = GameStore.fetchRequest()
           request.predicate = NSPredicate(format: "gameId == %@",gameId)
           
           request.includesSubentities = false
    
           let sortDescriptors = NSSortDescriptor(key: #keyPath(GameStore.gameNoteCreateTime), ascending: false)
           
           request.sortDescriptors = [sortDescriptors]
           request.returnsObjectsAsFaults = false
           fetchResultController = NSFetchedResultsController(fetchRequest:request, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
           fetchResultController.delegate = self
        
        
        do{
            try fetchResultController.performFetch()
            
            if let game = fetchResultController.fetchedObjects?.first{
                
                let loadedgame = StoreGameModels(gameUuid: game.gameUuid ?? UUID(), gameNoteCreateTime: game.gameNoteCreateTime, gameId: game.gameId ?? "",gameTitle: game.gameTitle ?? "", gameReleased: game.gameReleased ?? "", gameRating: game.gameRating ?? "", gameImageLink: game.gameImageLink ?? "", gameDescription: game.gameDescription ?? "", gameScreenshotsLinks: game.gameScreenshotsLinks ?? [String](), gameGenre: game.gameGenre ?? [String](), gameVideoPreviewImageLink: game.gameVideoPreviewImageLink, gameVideoLink: game.gameVideoLink)
                
                completion(loadedgame)
            }else {
                completion(nil)
            }

        } catch let error as NSError{
        print("error:\(error) \(error.userInfo)")
        }
                  
    }
    
    func loadFavouriteData(_ completion:@escaping ([StoreGameModels]) -> Void){
        gamesStoreInCoreData.removeAll()
        
        let request:NSFetchRequest<GameStore> = GameStore.fetchRequest()
        request.includesSubentities = false
        let sortDescriptors = NSSortDescriptor(key: #keyPath(GameStore.gameNoteCreateTime), ascending: false)
        
        request.sortDescriptors = [sortDescriptors]
        request.returnsObjectsAsFaults = false
        fetchResultController = NSFetchedResultsController(fetchRequest:request, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do{
            
            try fetchResultController.performFetch()
            
            
            guard let games = fetchResultController.fetchedObjects else {
                return
            }
            
            for game in games {

                let gameModel = StoreGameModels(gameUuid: game.gameUuid ?? UUID(), gameNoteCreateTime: game.gameNoteCreateTime, gameId: game.gameId ?? "", gameTitle: game.gameTitle ?? "", gameReleased: game.gameReleased ?? "", gameRating: game.gameRating ?? "", gameImageLink: game.gameImageLink ?? "", gameDescription: game.gameDescription ?? "", gameScreenshotsLinks: game.gameScreenshotsLinks ?? [String](), gameGenre: game.gameGenre ?? [String](), gameVideoPreviewImageLink: game.gameVideoPreviewImageLink, gameVideoLink: game.gameVideoLink)
                
                    self.gamesStoreInCoreData.append(gameModel)
            }
            
            
            let favourite = self.gamesStoreInCoreData
            
            completion(favourite)
            
        }catch let error as NSError{
            print("error:\(error) \(error.userInfo)")
        }
        
    }
    
    func isAlreadyRecord(_ contents:StoreGameModels) -> Bool{
        
        let request:NSFetchRequest<GameStore> = GameStore.fetchRequest()
        request.predicate = NSPredicate(format: "gameId == %@", contents.gameId)
        
        request.includesSubentities = false
 
        let sortDescriptors = NSSortDescriptor(key: #keyPath(GameStore.gameNoteCreateTime), ascending: false)
        
        request.sortDescriptors = [sortDescriptors]
        request.returnsObjectsAsFaults = false
        fetchResultController = NSFetchedResultsController(fetchRequest:request, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
               
               
        var results:[NSManagedObject] = []
         
        do{
            try fetchResultController.performFetch()
            
            if let data = fetchResultController.fetchedObjects{
                results = data
            }
            
        }catch{
             print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    func deleteGameCoreData(at indexPath:IndexPath ){
        
        let request:NSFetchRequest<GameStore> = GameStore.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: #keyPath(GameStore.gameNoteCreateTime), ascending: false)
        request.sortDescriptors = [sortDescriptors]
        request.returnsObjectsAsFaults = false
        fetchResultController = NSFetchedResultsController(fetchRequest:request, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do{
            try fetchResultController.performFetch()
                       
            let deletedgame = fetchResultController.object(at: indexPath)
            

                CoreDataStack.shared.managedContext.delete(deletedgame)
                
                CoreDataStack.shared.saveContext()
    
        
        }catch let error as NSError{
            print("error:\(error) \(error.userInfo)")
        }
        
    }
    
}









