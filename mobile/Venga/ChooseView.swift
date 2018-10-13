//
//  ChooseView.swift
//  Venga
//
//  Created by David Richards on 7/27/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit
import Material

class ChooseView: UIView {
    
    let numberUp = FABButton(image: UIImage.fontAwesomeIcon(name: .arrowUp, textColor: .white, size: CGSize(width: 25, height: 25)))
    let numberDown = FABButton(image: UIImage.fontAwesomeIcon(name: .arrowDown, textColor: .white, size: CGSize(width: 25, height: 25)))
    let groupCountView = UILabel()
    var number = 1
    var maxNumber = 10
    let cache = Cache.sharedInstance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(groupCountView)
        groupCountView.text = number.description
        groupCountView.textColor = .white
        groupCountView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        
        self.addSubview(numberDown)
        self.numberDown.backgroundColor = GlobalConst.backgroundColor
        numberDown.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(5)
            make.size.equalTo(40)
            make.centerY.equalTo(self)
        }
        
        self.addSubview(self.numberUp)
        self.numberUp.backgroundColor = GlobalConst.backgroundColor
        numberUp.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.right.equalTo(self).offset(-5)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
