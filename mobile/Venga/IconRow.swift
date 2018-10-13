//
//  IconRow.swift
//  Venga
//
//  Created by David Richards on 6/26/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import FontAwesome_swift

class IconRow: UITableViewCell {
    
    var collectionView: UICollectionView!
    let imageNames = ["fa-glass", "fa-leaf", "fa-taxi", "fa-bed", "fa-bicycle", "fa-camera-retro", "fa-coffee"] //Load Images in Image Assets load all  Image Names in Array
    let gameNames = ["Drinks", "Eco", "Taxi", "Bed", "Bikes", "Photos", "Coffee"] //Titles Array for Images

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Defaults
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: 60, height: 70)
        layout.scrollDirection = .horizontal
        
        //Assign Delegate for UICollectionView
        self.collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: "IconCell")
        self.contentView.addSubview(self.collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension IconRow: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: IconCell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCell
        cell.collectionImageView.image = UIImage.fontAwesomeIcon(code: imageNames[indexPath.row], textColor: .gray, size: CGSize(width: 30, height: 30), backgroundColor: .clear)
        cell.collectionImageTitle.text = gameNames[indexPath.row]
        print(gameNames[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let clickedIndex = imageNames[indexPath.row]
        NSLog("Clicked at index \(clickedIndex)")
    }
}
