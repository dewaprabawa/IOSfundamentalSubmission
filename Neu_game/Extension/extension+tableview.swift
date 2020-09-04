//
//  extension+tableview.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 09/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit


extension UITableView:ReusableCell{
    
    func registerReusableCell<T: UITableViewCell>(_:T.Type){
        if let nib = T.reuseNib {
            register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(at indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("failed to dequeue cell")
        }
        return cell
    }
}

extension UITableViewCell:ReusableCell{}

