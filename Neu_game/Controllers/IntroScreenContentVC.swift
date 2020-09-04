//
//  IntroScreenContentController.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 27/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class IntroScreenContentVC: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!{
        didSet{
            headerLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var subHeaderLabel: UILabel!{
        didSet{
            subHeaderLabel.numberOfLines = 0
        }
    }
    
    
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var contentsImage: UIImageView!
    
    
    var index = 0
    var header = ""
    var subHeader = ""
    var imgFile = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.headerLabel.text = self.header
            self.subHeaderLabel.text = self.subHeader
            self.contentsImage.image = UIImage(named: self.imgFile)
        
    }
}

