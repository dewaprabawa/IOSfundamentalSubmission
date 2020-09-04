//
//  GenreGameItem.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 12/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GenreGameItem: UICollectionViewCell {

    @IBOutlet var imageGenre: UIImageView!
    @IBOutlet var imageGenreView: UIView!
    @IBOutlet var nameGenre: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSetups()
    }
    
    
    private func imageSetups(){
        imageGenre.contentMode = .scaleAspectFill
        imageGenre.createshadowWithCorner(containerView: imageGenreView, cornerRadious: 10)
       }

}
