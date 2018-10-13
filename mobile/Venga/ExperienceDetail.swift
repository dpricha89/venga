//
//  ExperienceDetail.swift
//  Venga
//
//  Created by David Richards on 5/6/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import AlamofireImage
import ChameleonFramework

class ExperienceDetail: BaseTableController {
    
    var experience: Experience!
    var reviews: [Review]?
    var host: Host?
    let paymentButton = VengaButton()
    let slideshow = ImageSlideshow()
    var alomofireSource: [InputSource]!
    
    // experience constants
    let staticRows = 4

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the table
        self.setupUI()
        
        // Create an array of sources
        alomofireSource = experience.images.map { image in
            AlamofireSource(urlString: image.url)!
        }
        
        // Make the request to get reviews
        self.getReviews()
        // Make the request to get the host info
        self.getHost()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // this makes the images show up under the status bar.
        // Without this setting there would be a little black bar at the
        // top where the clock and other status items go.
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(true)
         self.navigationController?.isToolbarHidden = false
        // add the navigation bar here so we can get back to the main
        // destinations screen
        self.navigationController?.isNavigationBarHidden = false
        // add the share button to the right bar item on navigation controller
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareExperience))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.isToolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return 1
        } else if (section == 2 ){
            return 1
        } else if (section == 3) {
            return 2
        } else if (section == 4) {
            return 2
        } else if (section == 5){
            return experience.included.count
        } else if (section == 6) {
            return 1
        } else if (section == 7) {
            return 1
        } else if (section == 8) {
            return 1
        } else if (section == 9) {
            return reviews?.count ?? 0
        } else {
            return self.staticRows
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 260
        } else if (indexPath.section == 1) {
            return 40
        } else if (indexPath.section == 2) {
            return UITableViewAutomaticDimension
        } else if (indexPath.section == 3) {
            return 60
        } else if (indexPath.section == 4) {
            return 40
        } else if (indexPath.section == 5) {
            return 40
        } else if (indexPath.section == 6) {
            return 250
        } else if (indexPath.section == 7) {
            return UITableViewAutomaticDimension
        } else if (indexPath.section == 8) {
            return UITableViewAutomaticDimension
        } else if (indexPath.section == 9) {
            return UITableViewAutomaticDimension
        } else {
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return ""
        } else if (section == 1) {
            return ""
        } else if (section == 2 ){
            return ""
        } else if (section == 3) {
            return "Details"
        } else if (section == 4) {
            return "Highlights"
        } else if (section == 5){
            return "Included"
        } else if (section == 6) {
            return "Location"
        } else if (section == 7) {
            return "Host"
        } else if (section == 8) {
            return "Itinerary"
        } else if (section == 9) {
            return "Reviews"
        } else {
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            self.slideshow.presentFullScreenController(from: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        if (section > 2 && section != 6) {
            view.tintColor = UIColor.clear
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = .boldSystemFont(ofSize: 22)
            header.textLabel?.textColor = UIColor.white
            
            let border = UIView(frame: CGRect(x: 14, y: 5, width: (self.view.bounds.width - 28), height: 1))
            border.backgroundColor = .gray
            header.addSubview(border)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        view.tintColor = .clear
        footer.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section > 2 && section != 6) ? 55: 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (section > 2 && section != 6) ? 10: 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            // setup the sources
            cell.contentView.addSubview(self.slideshow)
            self.slideshow.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(cell.contentView)
                make.right.equalTo(cell.contentView)
                make.top.equalTo(cell.contentView)
                make.bottom.equalTo(cell.contentView)
            }
            self.slideshow.slideshowInterval = 5
            self.slideshow.setImageInputs(self.alomofireSource)
            self.slideshow.contentScaleMode = .scaleAspectFill
            
            print("slideshow height \(self.slideshow.bounds.height) width \(self.slideshow.bounds.width)")
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
            cell.titleLabel.text = experience.title
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            cell.textDescription.text = experience.description
            return cell
        } else if (indexPath.section == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
            if (indexPath.row == 0) {
                cell.firstKeyValue.text = "Age requirement"
                print(experience.details.ageRequirement)
                cell.firstValue.text = experience.details.ageRequirement.description + "+"
                cell.secondKeyValue.text = "Style"
                cell.secondValue.text = experience.details.style
            } else {
                cell.firstKeyValue.text = "Max group size"
                cell.firstValue.text = experience.details.groupSize.description
                print(experience.details.groupSize)
                cell.secondKeyValue.text = "Physical rating"
                cell.secondValue.text = experience.details.physicalRating.description + " out of 10"
            }
            return cell
        } else if (indexPath.section == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicImageCell", for: indexPath) as! BasicImageCell
            if (indexPath.row == 0) {
                cell.basicLabel.font = UIFont.fontAwesome(ofSize: 16)
                cell.basicLabel.text = String.fontAwesomeIcon(name: .clockO) + "  Duration of the trip: \(experience.prettyDuration())"
            } else if (indexPath.row == 1) {
                cell.basicLabel.font = UIFont.fontAwesome(ofSize: 16)
                cell.basicLabel.text = String.fontAwesomeIcon(name: .language) + "  Offered in \(experience.languages.joined(separator: ", "))"
            }
            return cell
        } else if (indexPath.section == 5) {
            let include = experience.included[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicImageCell", for: indexPath) as! BasicImageCell
            cell.basicLabel.text = include
            return cell
        } else if (indexPath.section == 6) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as! MapCell
            cell.addAnnotation(lat: experience.location.lat, lng: experience.location.lng)
            return cell
        } else if (indexPath.section == 7) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutHostCell", for: indexPath) as! AboutHostCell
            cell.hostName.text = self.host?.name
            cell.title.text = self.host?.title
            cell.hostDescription.text = self.host?.description
            if let imageUrl = self.host?.imageUrl {
                Alamofire.request(imageUrl).responseImage { response in
                    // get the image
                    if let image = response.result.value {
                        // add the image to the view as a rounded image
                        cell.hostImage.image = image.af_imageRoundedIntoCircle()
                    }
                }
            }
            return cell
        } else if (indexPath.section == 8) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            cell.textDescription.text = experience.itinerary
            return cell
        } else if (indexPath.section == 9) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            if let review = reviews?[indexPath.row] {
                cell.reviewComment.text = review.comment
                cell.reviewName.text = review.name
                cell.reviewDate.text = review.reviewDate.string(dateStyle: .short, timeStyle: .none)
                Alamofire.request(review.imageUrl).responseImage { response in
                    // get the image
                    if let image = response.result.value {
                        // add the image to the view as a rounded image
                        cell.reviewImage.image = image.af_imageRoundedIntoCircle()
                    }
                }
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IconRow", for: indexPath) as! IconRow
            return cell
        }
    }

    func setupUI() {
        
        var toolBarItems = [UIBarButtonItem]()
        
        // create the price label and add it to the toolbar as custom view
        let priceLabel = UILabel(frame: CGRect.zero)
        priceLabel.text = "\(experience.prettyPrice())/per person"
        priceLabel.sizeToFit()
        priceLabel.backgroundColor = .clear
        priceLabel.textColor = GlobalConst.menuItemColor
        priceLabel.textAlignment = .center
        let toolbarItem1 = UIBarButtonItem.init(customView: priceLabel)
        toolBarItems.append(toolbarItem1)
        
        // create the flex space
        let toolbarItem2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBarItems.append(toolbarItem2)

        // add the custom book now button
        self.paymentButton.setTitle("    Request Booking    ", for: .normal)
        self.paymentButton.backgroundColor = GlobalConst.vengaWatermelon
        self.paymentButton.sizeToFit()
        self.paymentButton.addTarget(self, action: #selector(bookNowClicked), for: .touchUpInside)
        let toolbarItem3 = UIBarButtonItem.init(customView: self.paymentButton)
        toolBarItems.append(toolbarItem3)
        
        self.setToolbarItems(toolBarItems, animated: true)
        self.navigationController?.toolbar.barStyle = .default
        self.navigationController?.toolbar.barTintColor = GlobalConst.backgroundColor
    }
    
    func bookNowClicked() {
        // Assign the price to payment model
        self.cache.paymentModel.price = experience.price
        self.cache.selectedExperience = experience
        
        // Setup the controllers
        let calendar = Calendar()
        
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.pushViewController(calendar, animated: true)
    }
    
    func shareExperience() {
        let shareText = experience.title
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        self.present(vc, animated: true)
    }

    func getReviews() {
        self.backend.getReviews(experienceId: experience.id) { reviews, error in
            
            if let error = error {
                NSLog(error.localizedDescription)
                return
            }
            
            self.reviews = reviews
            // reload the table to ensure the reviews show up
            self.tableView.reloadData()
        }
    }
    
    func getHost() {
        self.backend.getHost(hostId: experience.hostId) { host, error in
            
            if let error = error {
                NSLog(error.localizedDescription)
                return
            }
            
            self.host = host
            // reload the table to ensure the reviews show up
            self.tableView.reloadData()
        }
    }
    
    
}
