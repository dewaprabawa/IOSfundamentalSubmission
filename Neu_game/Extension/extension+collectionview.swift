//
//  extension+collectionview.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 09/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView: ReusableCell {
    
    func registerReusableItem<T: UICollectionViewCell>(_:T.Type){
        if let nib = T.reuseNib {
            register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    
    func dequeueReusableItem<T: UICollectionViewCell>(at indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("failed to dequeue cell")
        }
        return cell
    }
    
}

extension UICollectionViewCell: ReusableCell{}
