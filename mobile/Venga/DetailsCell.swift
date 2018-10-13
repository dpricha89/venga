//
//  DetailsCell.swift
//  Venga
//
//  Created by David Richards on 7/22/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class DetailsCell: UITableViewCell {
    
    var firstKeyValue = UILabel()
    var firstValue = UILabel()
    var secondKeyValue = UILabel()
    var secondValue = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Make the select color none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        let middle = self.contentView.bounds.width/2
        let width = self.contentView.bounds.width
        
        
        self.contentView.addSubview(self.firstKeyValue)
        self.firstKeyValue.textColor = .white
        self.firstKeyValue.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(middle)
        }
        
        self.contentView.addSubview(self.firstValue)
        self.firstValue.font = .boldSystemFont(ofSize: 16)
        self.firstValue.textColor = .white
        self.firstValue.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.firstKeyValue.snp.bottom).offset(5)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(middle)
        }
        
        
        self.contentView.addSubview(self.secondKeyValue)
        self.secondKeyValue.textColor = .white
        self.secondKeyValue.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.contentView).offset(middle + 20)
            make.right.equalTo(width).offset(-5)
        }
        
        self.contentView.addSubview(self.secondValue)
        self.secondValue.textColor = .white
        self.secondValue.font = .boldSystemFont(ofSize: 16)
        self.secondValue.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.secondKeyValue.snp.bottom).offset(5)
            make.left.equalTo(self.contentView).offset(middle + 20)
            make.right.equalTo(width).offset(-5)
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
