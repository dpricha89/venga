//
//  Experiences.swift
//  Venga
//
//  Created by David Richards on 5/4/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import DZNEmptyDataSet
import SnapKit

class ExperiencesTable: BaseTableController {
    
    // travel data
    var destination: Destination!
    var experiences: [Experience]!
    
    // experiences constants
    let staticRows = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup table
        self.setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // this makes the images show up under the status bar.
        // Without this setting there would be a little black bar at the
        // top where the clock and other status items go.
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        // add the navigation bar here so we can get back to the main
        // destinations screen
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.experiences.count + self.staticRows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == 1 {
            return  45
        } else if indexPath.row == 2 {
            return UITableViewAutomaticDimension
        } else {
            return 70
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected index \(indexPath.row)")
        print("Modified index \(indexPath.row - self.staticRows)")
        if (indexPath.row > staticRows - 1) {
            let experienceDetail = ExperienceDetail()
            experienceDetail.experience = self.experiences[indexPath.row - self.staticRows]
            self.navigationController?.pushViewController(experienceDetail, animated: true)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DestinationCell", for: indexPath) as! DestinationCell
            // add the image
            Alamofire.request(destination.imageUrl).responseImage { response in
                // get the image
                if let image = response.result.value {
                    // scale the photo
                    let aspectScaledToFitImage = image.af_imageAspectScaled(toFill: CGSize(width: cell.bounds.width, height: cell.bounds.height))
                    // add filters
                    let chromeImage = aspectScaledToFitImage.af_imageFiltered(withCoreImageFilter: "CIPhotoEffectChrome")
                    // add the image to the view
                    cell.backgroundView = UIImageView(image: chromeImage)
                    // stop the spinner
                    cell.spinner.stopAnimating()
                }
            }
            
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            cell.backgroundColor = .clear
            let sectionTitle = UILabel()
            // setup the title
            sectionTitle.text = destination.title
            sectionTitle.textColor = GlobalConst.sectionTitleColor
            sectionTitle.font = .systemFont(ofSize: 25)
            cell.addSubview(sectionTitle)
            sectionTitle.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(GlobalConst.largeLabelhieght)
                make.left.equalTo(cell).offset(GlobalConst.smallLeftOffset)
                make.bottom.equalTo(cell)
            }
            // remove the cell selector hightlight
            cell.selectionStyle = .none
            return cell
        }else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            cell.textDescription.text = destination.description
            return cell
        } else {
            // we have to modify the index because of the the first row is a photo
            let modIndex = indexPath.row - self.staticRows
            let experience = self.experiences[modIndex]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCell", for: indexPath) as! ExperienceCell
            
            // set the title of the experience
            cell.experienceTitle.text = experience.title
            
            // set the image of the experience
            if let imageUrl = experience.images.first?.url {
                NSLog("Image URL \(imageUrl)")
                Alamofire.request(imageUrl).responseImage { response in
                    // get the image
                    if let image = response.result.value {
                        // add filters
                        NSLog("Image URL \(image.description)")
                        // add the image to the view
                        cell.experienceImage.image = image.af_imageRoundedIntoCircle()
                    }
                }
            }
            
            return cell
        }
    }

}
