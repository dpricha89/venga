//
//  VengaField.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import TextFieldEffects

class VengaField: KaedeTextField, UITextFieldDelegate {
    
    

    override public func layoutSubviews() {
        super.layoutSubviews()
        defaultSettings()
    }
    
    private func defaultSettings() {
        
        // set the placeholder and text color
        self.textColor = .white
        self.placeholderColor = .white
        
        // add an underline
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
