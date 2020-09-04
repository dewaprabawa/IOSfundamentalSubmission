//
//  GameDescriptionCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 17/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GameDescriptionCell: UITableViewCell {

    
    var watchTrailer: (()-> Void)?
    var visitStore: (()-> Void)?
    var readMore:(()-> Void)?
    
    
    @IBOutlet weak var GameDetailDescription:UILabel!
    @IBOutlet weak var GameReleaseDate: UILabel!
    @IBOutlet weak var GameGenre: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func watchTrailer(_ sender:UIButton){
        watchTrailer?()
    }
    
    @IBAction func visitStore(_ sender:UIButton){
        visitStore?()
    }
    
    @IBAction func readMore(_ sender:UIButton){
        readMore?()
    }
    
}
