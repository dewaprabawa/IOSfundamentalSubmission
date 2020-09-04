//
//  PinterestLayoutDelegate.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 01/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}
