//
//  ExperienceCell.swift
//  Venga
//
//  Created by David Richards on 5/6/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class TripCell: UITableViewCell {
    
    var tripTitle = UILabel()
    var tripDate = UILabel()
    var tripStatus = UILabel()
    var tripImage = UIImageView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // Make the select color none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        // set the image settings
        self.contentView.addSubview(self.tripImage)
        self.tripImage.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(GlobalConst.smallLeftOffset)
            make.width.equalTo(GlobalConst.paymentImageWidth)
            make.height.equalTo(GlobalConst.paymentImageWidth)
        }
        
        // set the title color
        self.tripTitle.textColor = .white
        self.contentView.addSubview(self.tripTitle)
        self.tripTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(GlobalConst.topOffset)
            make.left.equalTo(self.tripImage.snp.right).offset(GlobalConst.smallLeftOffset)
        }
        
        self.contentView.addSubview(self.tripStatus)
        self.tripStatus.textColor = .white
        self.tripStatus.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.tripTitle.snp.bottom).offset(GlobalConst.smallTopOffset)
            make.left.equalTo(self.tripImage.snp.right).offset(GlobalConst.smallLeftOffset)
        }
        
        self.tripDate.textColor = .gray
        self.contentView.addSubview(self.tripDate)
        self.tripDate.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.tripStatus.snp.bottom).offset(GlobalConst.smallTopOffset)
            make.left.equalTo(self.tripImage.snp.right).offset(GlobalConst.smallLeftOffset)
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
