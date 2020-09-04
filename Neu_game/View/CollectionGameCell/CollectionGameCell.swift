//
//  CollectionGameCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 16/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class CollectionGameCell: UITableViewCell {

    @IBOutlet weak var imageCollection: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var collectionUIview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageCollection.roundCorners(corners: [.allCorners], radius: 30)
        
    }

}
