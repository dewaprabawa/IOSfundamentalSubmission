//
//  ReuseableCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 09/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

protocol ReusableCell {
    
    static var reuseIdentifier: String { get }
    
    static var reuseNib: UINib? { get }

}


extension ReusableCell {
    
     static var reuseIdentifier:String {
        return String(describing: self)
    }
    
   static var reuseNib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}




