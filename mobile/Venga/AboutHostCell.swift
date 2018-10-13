//
//  AboutHostCell.swift
//  Venga
//
//  Created by David Richards on 7/22/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class AboutHostCell: UITableViewCell {
    
    let hostName = UILabel()
    let title = UILabel()
    let hostImage = UIImageView()
    let hostDescription = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Make the select color none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.contentView.addSubview(self.hostImage)
        self.hostImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(7)
            make.left.equalTo(self.contentView).offset(10)
            make.size.equalTo(40)
        }
        
        self.contentView.addSubview(self.hostName)
        self.hostName.font = .boldSystemFont(ofSize: 17)
        self.hostName.textColor = .white
        self.hostName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.hostImage.snp.right).offset(10)
        }
        
        self.contentView.addSubview(self.title)
        self.title.textColor = .gray
        self.title.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.hostName.snp.bottom).offset(3)
            make.left.equalTo(self.hostImage.snp.right).offset(10)
        }
        
        self.contentView.addSubview(self.hostDescription)
        self.hostDescription.numberOfLines = 0
        self.hostDescription.sizeToFit()
        self.hostDescription.textColor = .white
        self.hostDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.title.snp.bottom).offset(10)
            make.left.equalTo(self.hostImage.snp.right).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
