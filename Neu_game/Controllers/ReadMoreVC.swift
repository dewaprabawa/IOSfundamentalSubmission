//
//  ReadMoreVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 15/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit


class ReadMoreVC: UIViewController {
    
    
    var descriptionGame:String?
    
    @IBOutlet weak var descriptionGameDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionGameDetail.text = descriptionGame
    }
}
