//
//  CoreDataStack.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 26/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//


import CoreData

// MARK: - Core Data stack

class CoreDataStack {
    
    static var shared = CoreDataStack()
    
    
    lazy var managedContext: NSManagedObjectContext = {
      return self.storeContainer.viewContext
    }()

    private lazy var storeContainer: NSPersistentContainer = {

      let container = NSPersistentContainer(name: "Neu_game")
      container.loadPersistentStores {
        (storeDescription, error) in
        if let error = error as NSError? {
           
        }
      }
      return container
    }()

    func saveContext () {
        
      guard managedContext.hasChanges else { return }
        
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
}
