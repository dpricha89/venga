//
//  ReviewCell.swift
//  Venga
//
//  Created by David Richards on 7/22/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class ReviewCell: UITableViewCell {
    
    let reviewName = UILabel()
    let reviewDate = UILabel()
    let reviewImage = UIImageView()
    let reviewComment = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Make the select color none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.contentView.addSubview(self.reviewImage)
        self.reviewImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(8)
            make.left.equalTo(self.contentView).offset(10)
            make.size.equalTo(40)
        }
        
        self.contentView.addSubview(self.reviewName)
        self.reviewName.textColor = .white
        self.reviewName.font = .boldSystemFont(ofSize: 17)
        self.reviewName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.reviewImage.snp.right).offset(10)
        }
        
        self.contentView.addSubview(self.reviewDate)
        self.reviewDate.textColor = .gray
        self.reviewDate.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.reviewName.snp.bottom).offset(3)
            make.left.equalTo(self.reviewImage.snp.right).offset(10)
        }
        
        self.contentView.addSubview(self.reviewComment)
        self.reviewComment.textColor = .white
        self.reviewComment.numberOfLines = 0
        self.reviewComment.sizeToFit()
        self.reviewComment.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.reviewDate.snp.bottom).offset(10)
            make.left.equalTo(self.reviewImage.snp.right).offset(10)
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
