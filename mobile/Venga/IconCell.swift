//
//  IconCell.swift
//  Venga
//
//  Created by David Richards on 6/26/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class IconCell: UICollectionViewCell {
    
    var collectionImageView = UIImageView()
    var collectionImageTitle = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Setup the image icon size
        self.contentView.addSubview(self.collectionImageView)
        collectionImageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        // Setup the icon label right below the image
        self.collectionImageTitle.font = .systemFont(ofSize: 12)
        self.collectionImageTitle.textAlignment = .center
        self.collectionImageTitle.textColor = .white
        self.contentView.addSubview(self.collectionImageTitle)
        self.collectionImageTitle.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.collectionImageView.snp.bottom)
        }
    }
}
