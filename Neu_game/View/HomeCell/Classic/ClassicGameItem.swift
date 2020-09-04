//
//  ClassicGameItem.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 12/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class ClassicGameItem: UICollectionViewCell {

    @IBOutlet weak var imageClassic: UIImageView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var nameClassic: UILabel!
    @IBOutlet weak var rating:UILabel!
    @IBOutlet weak var releaseded: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSetup()
    }

    private func imageSetup(){
        imageClassic.contentMode = .scaleAspectFill
        imageClassic.createshadowWithCorner(containerView: imageView, cornerRadious: 10)
    }
}
