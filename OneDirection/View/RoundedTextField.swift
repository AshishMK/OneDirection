//
//  RoundedTextField.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 4/4/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
import UIKit
class RoundedTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.init(red: 64, green: 64, blue: 64).cgColor
        backgroundColor = UIColor.white
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = CGRect(x: bounds.origin.x + 16, y: bounds.origin.y, width: bounds.size.width - 16, height: bounds.size.height)
        return insetBounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = CGRect(x: bounds.origin.x + 8, y: bounds.origin.y, width: bounds.size.width - 16, height: bounds.size.height)
        return insetBounds
    }
    
}
