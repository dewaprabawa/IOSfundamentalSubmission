//
//  extension+image.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 08/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    public func createRoundedCorners(_ radius:CGFloat? = nil) -> UIImage? {
        let maximumRadius = min(size.width, size.height)/2
        var cornerRadius: CGFloat
        
        if let radius = radius, radius > 0 && radius <= maximumRadius {
            cornerRadius = radius
        }else{
            cornerRadius = maximumRadius
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
       
}



extension UIImageView {
func createshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
    containerView.clipsToBounds = false
    containerView.layer.shadowColor = UIColor.black.cgColor
    containerView.layer.shadowOpacity = 1.0
    containerView.layer.shadowOffset = CGSize(width: 1, height: 1.5)
    containerView.layer.shadowRadius = 3
    containerView.layer.cornerRadius = cornerRadious
    self.clipsToBounds = true
    self.layer.cornerRadius = cornerRadious
    }
}
