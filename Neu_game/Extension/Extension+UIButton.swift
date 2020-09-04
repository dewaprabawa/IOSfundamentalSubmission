//
//  Extension+UIButton.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 13/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit

final class CustomButton: UIButton {

    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 50).cgPath
            if self.backgroundColor != nil {
                shadowLayer.fillColor = self.backgroundColor?.cgColor
            }
            else{
                shadowLayer.fillColor = UIColor.white.cgColor
            }
            shadowLayer.shadowColor = UIColor.gray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 3

            layer.insertSublayer(shadowLayer, at: 0)

        }

    }

}
