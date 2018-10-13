//
//  CreditCard.swift
//  Venga
//
//  Created by David Richards on 7/28/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit

class CreditCard: UIView {

    let cardNumbers = UILabel()
    let cardImage = UIImageView()
    let cardName = UILabel()
    let editCardButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup the rounded corners
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        // Setup the card name first
        self.addSubview(self.cardName)
        self.cardName.textColor = .white
        self.cardName.text = "John Doe"
        self.cardName.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(self).offset(10)
        }
        
        // Setup the card numbers
        self.addSubview(self.cardNumbers)
        self.cardNumbers.textColor = .white
        self.cardNumbers.font = .systemFont(ofSize: 20)
        self.cardNumbers.text = "•••• •••• •••• ••••"
        self.cardNumbers.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self.cardName.snp.top).offset(-10)
        }
        
        // Setup the card image
        self.addSubview(self.cardImage)
        self.cardImage.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(GlobalConst.paymentImageWidth)
            make.height.equalTo(GlobalConst.paymentImageHeight)
        }
        
        // Add the edit card image
        self.addSubview(self.editCardButton)
        self.editCardButton.setBackgroundImage(UIImage.fontAwesomeIcon(name: .edit, textColor: .white, size: CGSize(width: 30, height: 30)), for: .normal)
        self.editCardButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(cardTitle: String) {
        if !cardTitle.contains("Apple") {
           let digits = cardTitle.components(separatedBy: " ")[1]
           self.cardNumbers.text = "•••• •••• •••• " + digits
        } else {
            self.cardNumbers.text = "•••• •••• •••• ••••"
        }
    }
}
