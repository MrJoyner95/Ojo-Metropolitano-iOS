//
//  RoundText.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Jesus Reynaga Rodriguez on 05/09/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit

@IBDesignable
class RoundTXT: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
