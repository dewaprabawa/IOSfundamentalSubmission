//
//  AddCollectionsVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 30/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import CoreData
import Nuke
import MaterialComponents.MaterialDialogs

class AddCollectionsVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var collectionImageView:UIImageView!
    @IBOutlet weak var collectionGameTitle:UILabel!
    
    @IBOutlet weak var summaryTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var lastTextField: UITextField!
    
    
    var selectedGame: StoreGameModels?
    
    let newCollection = GameCollection(context:CoreDataStack.shared.managedContext)
    
    override func viewDidLoad() {
        summaryTextField.delegate = self
        summaryTextField.becomeFirstResponder()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionGameTitle.text = selectedGame?.gameTitle
        NWService.shared.downloadImage(selectedGame?.gameImageLink ?? "", collectionImageView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCollection()
        return true
    }
    
    @IBAction func addCollections(_ sender: Any) {
        addCollection()
    }
    
    
    private func addCollection(){
        guard let summaryText = summaryTextField.text, !summaryText.isEmpty else {
            alertshowIsFilled()
          return
        }
        newCollection.name = collectionGameTitle.text
        newCollection.note = summaryText
        
        guard let rateText = rateTextField.text, !rateText.isEmpty else {
           alertshowIsFilled()
            return
        }
        newCollection.rating = rateText
        newCollection.image = selectedGame?.gameImageLink
        
        guard let lastText = lastTextField.text, !lastText.isEmpty else {
            alertshowIsFilled()
            return
        }
        newCollection.lastStage = lastText
        
       try! CoreDataStack.shared.managedContext.save()
        
        tabBarController?.selectedIndex = 3
        
        summaryTextField.text = ""
        lastTextField.text = ""
        rateTextField.text = ""
        
        navigationController?.popViewController(animated: true)
    }
    
        
}


extension AddCollectionsVC{
    
    func alertshowIsFilled(){
        
         let alerController = MDCAlertController(title: "Caution", message: "please do not empty the field")
          alerController.titleIcon = UIImage(named: "icons8-warning-shield-40")
          let action = MDCAlertAction(title:"Exit") { (action) in print("Exit") }
             alerController.addAction(action)
             present(alerController, animated: true, completion: nil)
      }
}
