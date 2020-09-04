//
//  SearchGameCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 18/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class SearchGameCell: UITableViewCell {

    @IBOutlet weak var imageSearch: UIImageView!
    @IBOutlet weak var titleSearch: UILabel!
    @IBOutlet weak var activitySearch: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSetups()
    }
    
    
    private func imageSetups(){
        imageSearch.contentMode = .scaleAspectFill
        imageSearch.clipsToBounds = false
        imageSearch.layer.masksToBounds = true
        imageSearch.layer.cornerRadius = 10
    }
}
