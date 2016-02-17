//
//  BorderedRoundedView.swift
//  Designables
//
//  Created by Blake Oistad on 11/11/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

@IBDesignable

class BorderedRoundedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius                   //creates corner radius
            layer.masksToBounds = cornerRadius > 0              //only mask to bounds if corner radius is greater than 0, clips remaining corner color of original object, but only if theres a radius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
}
