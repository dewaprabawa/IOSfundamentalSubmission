//
//  GamePlatformItem.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 15/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GamePlatformItem: UICollectionViewCell {

    @IBOutlet weak var imagePlatform: UIImageView!
    @IBOutlet weak var titlePlatform: UILabel!
    @IBOutlet weak var viewPlatform: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     imageSetup()
    }
    
        private func imageSetup(){
        imagePlatform.contentMode = .scaleAspectFill
        imagePlatform.createshadowWithCorner(containerView: viewPlatform, cornerRadious: 0)
    }

    
   
}
