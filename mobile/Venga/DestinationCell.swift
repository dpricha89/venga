//
//  DestinationCell.swift
//  Venga
//
//  Created by David Richards on 5/4/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class DestinationCell: UITableViewCell {
    var destinationTitle = UILabel()
    var spinner = UIActivityIndicatorView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Make the select color none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        // setup the destination title
        destinationTitle.textColor = GlobalConst.destinationTitleColor
        destinationTitle.font = .systemFont(ofSize: 22)
        contentView.addSubview(self.destinationTitle)
        self.destinationTitle.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(GlobalConst.buttonHeight)
            make.right.equalTo(contentView).offset(GlobalConst.smallRightOffset)
            make.bottom.equalTo(contentView).offset(GlobalConst.smallBottomOffset)
        }
        
        self.spinner.startAnimating()
        contentView.addSubview(self.spinner)
        self.spinner.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(GlobalConst.buttonHeight)
            make.center.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
