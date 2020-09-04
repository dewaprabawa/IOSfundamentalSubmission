//
//  GameFavCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 19/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GameFavCell: UITableViewCell {

    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSetups()
    }
    
    private func imageSetups(){
           favImage.contentMode = .scaleAspectFill
           favImage.clipsToBounds = false
           favImage.layer.masksToBounds = true
           favImage.layer.cornerRadius = 10
       }
}
