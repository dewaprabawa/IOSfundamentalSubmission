//
//  GameGalleryCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 17/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GameGalleryCell: UITableViewCell {

    
    var moreGallery: (()->Void)?
    
    @IBOutlet weak var GameImage0: UIImageView!
    @IBOutlet weak var GameImage1: UIImageView!
    @IBOutlet weak var GameImage2: UIImageView!
    @IBOutlet weak var GameImage3: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func MoreGallery(_ sender:UIButton){
        moreGallery?()
    }
    
}
