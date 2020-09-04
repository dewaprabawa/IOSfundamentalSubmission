//
//  GameFavVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 19/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialDialogs
import CoreData

class GameFavVC: UIViewController, UITabBarControllerDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageLable:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupviews()
        self.title = "Save Games"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
   public struct KeyForUD {
        static var gameKey = "gamelist"
    }
    
    var rowsToDisplay = [StoreGameModels]()
    
    var segmentDictionary: [String: [StoreGameModels]]?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         //MARK: - fetch data!
            
        CoreDataManager.stack.loadFavouriteData{ (game) in
                      DispatchQueue.main.async {
                         
                        self.rowsToDisplay = game
                        self.tableView.reloadData()
                    
                }
          }
        
    
    }
    
    private func setupviews(){
        tableViewSetups()
        setupMessageLabel()
        update()
    }
    
    private func update(){
        messageLable.isHidden = false
    }
        
    private func tableViewSetups(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerReusableCell(GameFavCell.self)
    }
    
    private func setupMessageLabel(){
        self.messageLable.text = "No Games Added yet"
    }
    

    func configureCellFav(_ cell: GameFavCell, at indexPath: IndexPath){
        let title = rowsToDisplay[indexPath.row].gameTitle
        let image = rowsToDisplay[indexPath.row].gameImageLink
        cell.favTitle.text = title
        cell.favTitle.font = UIFont.boldSystemFont(ofSize: 20)
        NWService.shared.downloadImage(image, cell.favImage)
    }
    
    
    @IBAction func segmentedHandle(_ sender:UISegmentedControl){
        DispatchQueue.main.async {
            let segment = Favorites.segmentCells.data[sender.selectedSegmentIndex]
            if let array = self.segmentDictionary?[segment]{
                     let sortedArray = array.sorted(by: {$0.gameNoteCreateTime > $1.gameNoteCreateTime})

                      self.rowsToDisplay = sortedArray
                
                 self.tableView.reloadData()
                
                  }else {
                      self.rowsToDisplay = []
                  }
            
                self.tableView.reloadData()
        }
      
    }
    
}


extension GameFavVC: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rowsToDisplay.count > 0{
            messageLable.isHidden = true
            return rowsToDisplay.count
        }else {
            messageLable.isHidden = false
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GameFavCell = tableView.dequeueReusableCell(at: indexPath)
    
        configureCellFav(cell, at: indexPath)
 
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let items = rowsToDisplay[indexPath.item]
        if let vc = storyboard?.instantiateViewController(identifier: "GameDetailScrollView") as? GameDetailScrollView{
                  vc.game = items
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           alertshowExisted(at: indexPath)
        }
    }
    
    func alertshowExisted(at indexPath: IndexPath){
              
          let alerController = MDCAlertController(title: "Caution", message: "Do you really want to delete this permanently ?")
           alerController.titleIcon = UIImage(named: "icons8-warning-shield-40")
           let action = MDCAlertAction(title:"Delete") { (action) in
            
            self.rowsToDisplay.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            CoreDataManager.stack.deleteGameCoreData(at: indexPath)
            
        }
        
        let actionCancel = MDCAlertAction(title:"Cancel") { (action) in print("cancel")}
              
              alerController.addAction(action)
              alerController.addAction(actionCancel)
              present(alerController, animated: true, completion: nil)
        
          }
    
    }



extension GameFavVC{
    
    private enum Segue {
           static var DetailGameController = "GameDetailScrollView"
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let identifier = segue.identifier else { return }
            
            if Segue.DetailGameController == identifier {
                let destination = segue.destination as? GameDetailScrollView
                destination?.game = sender as? StoreGameModels
            }
        }
        
}



