//
//  PaymentRow.swift
//  Venga
//
//  Created by David Richards on 5/7/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class PaymentRow: UIView {
    
    let paymentImage = UIImageView()
    let paymentName = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add payment name
        self.paymentName.text = "Choose Payment >"
        self.paymentName.textColor = .white
        self.paymentName.textAlignment = .center
        self.addSubview(self.paymentName)
        self.paymentName.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.height.equalTo(GlobalConst.labelHeight)
        }
        
        // add payment image
        self.addSubview(self.paymentImage)
        self.paymentImage.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.right.equalTo(self.paymentName.snp.left).offset(GlobalConst.smallRightOffset)
            make.width.equalTo(GlobalConst.paymentImageWidth)
            make.height.equalTo(GlobalConst.paymentImageHeight)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
