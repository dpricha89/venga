//
//  VengaButton.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

class VengaButton: UIButton {

    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutRoundRectLayer()
    }
    
    private func layoutRoundRectLayer() {
        self.layer.cornerRadius = GlobalConst.cornerRadius
        self.titleLabel?.textColor = GlobalConst.buttonTextColor
    }

}
