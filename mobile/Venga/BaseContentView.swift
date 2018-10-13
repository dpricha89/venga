//
//  BaseContentView.swift
//  Venga
//
//  Created by David Richards on 4/30/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class BaseContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = GlobalConst.vengaWatermelon
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = GlobalConst.vengaWatermelon
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
