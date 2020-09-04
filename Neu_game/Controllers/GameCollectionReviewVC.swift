//
//  LoaderViewController.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 26/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import CoreData


class GameCollectionReviewVC: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    lazy private var fetchResultcController: NSFetchedResultsController<GameCollection> = {
        
        let fetchRequest:NSFetchRequest<GameCollection> = GameCollection.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(GameCollection.name), ascending: false)]
        
        let fetchResultcController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultcController.delegate = self
        
        return fetchResultcController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupviews()
        tableView.isHidden = false
        messageLabel.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchGameCollection()
        updateView()
    }
    
    private func fetchGameCollection(){
        do{
            try fetchResultcController.performFetch()
        }catch let error as NSError {
        print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    var hasGame:Bool{
        guard let game = fetchResultcController.fetchedObjects else { return false }
        return game.count > 0
    }
    
    private func updateView(){
        tableView.isHidden = !hasGame
        messageLabel.isHidden = hasGame
    }
    
    private func setupviews(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Collections"

        tableViewSetups()
    }
    
    private func tableViewSetups(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusableCell(CollectionGameCell.self)
        
    }
    
    private func configure(_ cell: CollectionGameCell, at indexPath: IndexPath){
        let newCollection = fetchResultcController.object(at: indexPath) 
        cell.lastLabel.text = newCollection.lastStage
        cell.summaryLabel.text = newCollection.note
        NWService.shared.downloadImage(newCollection.image ?? "", cell.imageCollection)
        cell.titleLabel.text = newCollection.name
        cell.ratingLabel.text = newCollection.rating
    
    }

}

extension GameCollectionReviewVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultcController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = fetchResultcController.sections?[section] else { return 0 }
        return count.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CollectionGameCell = tableView.dequeueReusableCell(at: indexPath)
        configure(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let deleteGame = fetchResultcController.object(at: indexPath)
        CoreDataStack.shared.managedContext.delete(deleteGame)
        CoreDataStack.shared.saveContext()
    }
}


extension GameCollectionReviewVC{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
     tableView.beginUpdates() }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! CollectionGameCell
                configure(cell, at: indexPath)
            }
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        @unknown default:
              print("Unexpected NSFetchedResultsChangeType")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         tableView.endUpdates()
        
    }
       
}


