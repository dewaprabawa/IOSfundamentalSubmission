//
//  GenresListCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 01/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GenresListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageGenreView: UIImageView!
    @IBOutlet weak var labelGenreTitle: UILabel!
    @IBOutlet weak var ratingGenreTitle: UILabel!
    @IBOutlet weak var dateReleaseTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageGenreView.layer.cornerRadius = 10
        imageGenreView.clipsToBounds = false
        imageGenreView.layer.masksToBounds = true
    }

}
