//
//  UpComingItem.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 08/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import Nuke


class UpComingItem: UICollectionViewCell {
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemImageView: UIView!
    @IBOutlet var rating: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var released: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        setupviews()
    }
    
    private func setupviews(){
        imageSetups()
    }
    
    private func imageSetups(){
        itemImage.contentMode = .scaleAspectFill
        itemImage.createshadowWithCorner(containerView: itemImageView, cornerRadious: 10)
    }
    
}
