//
//  TitleCell.swift
//  Venga
//
//  Created by David Richards on 7/22/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {
    
    let titleLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.titleLabel.textColor = GlobalConst.sectionTitleColor
        self.titleLabel.font = .systemFont(ofSize: 25)
        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(GlobalConst.largeLabelhieght)
            make.left.equalTo(self.contentView).offset(GlobalConst.smallLeftOffset)
            make.bottom.equalTo(self.contentView)
        }
    }
}
