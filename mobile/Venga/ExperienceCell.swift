//
//  ExperienceCell.swift
//  Venga
//
//  Created by David Richards on 5/6/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class ExperienceCell: UITableViewCell {
    
    var experienceTitle = UILabel()
    var experienceImage = UIImageView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // Make the select color none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        // set the image settings
        self.contentView.addSubview(self.experienceImage)
        self.experienceImage.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(GlobalConst.smallLeftOffset)
            make.width.equalTo(GlobalConst.paymentImageWidth)
            make.height.equalTo(GlobalConst.paymentImageWidth)
        }
        
        // set the title color
        self.experienceTitle.textColor = .white
        self.contentView.addSubview(self.experienceTitle)
        self.experienceTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(GlobalConst.smallTopOffset)
            make.left.equalTo(self.experienceImage.snp.right).offset(GlobalConst.smallLeftOffset)
            make.bottom.equalTo(self.contentView).offset(GlobalConst.smallBottomOffset)
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
