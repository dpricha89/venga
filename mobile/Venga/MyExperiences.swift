//
//  ExperienceEditor.swift
//  Venga
//
//  Created by David Richards on 8/6/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MyExperiences: BaseTableController {
    
    var hostExperiences = [Experience]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var toolBarItems = [UIBarButtonItem]()
        
        // create the flex space
        let toolbarItem2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBarItems.append(toolbarItem2)
        
        // add the custom book now button
        let paymentButton = VengaButton()
        paymentButton.setTitle("    Add experience    ", for: .normal)
        paymentButton.backgroundColor = GlobalConst.vengaWatermelon
        paymentButton.sizeToFit()
        paymentButton.addTarget(self, action: #selector(addNewExperience), for: .touchUpInside)
        let toolbarItem = UIBarButtonItem.init(customView: paymentButton)
        toolBarItems.append(toolbarItem)
        
        self.setToolbarItems(toolBarItems, animated: true)
        self.navigationController?.toolbar.barStyle = .default
        self.navigationController?.toolbar.barTintColor = GlobalConst.backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.isToolbarHidden = false
        self.refreshData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.hostExperiences.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let experience = self.hostExperiences[indexPath.row]
        // Instantiate a cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TripCell") as! TripCell
        cell.tripTitle.text = experience.title
        // convert the iso 8601 date back to date object
        var formatedDate = "N/A"

        cell.tripDate.text = "Date: " + formatedDate
        cell.tripStatus.text = "Status: "
        // set the image of the experience
        if let imageUrl = experience.images.first?.url {
            Alamofire.request(imageUrl).responseImage { response in
                // get the image
                if let image = response.result.value {
                    // add the image to the view
                    cell.tripImage.image = image.af_imageRoundedIntoCircle()
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
    }
    
    func addNewExperience() {
        print("Trying to add new experience")
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.pushViewController(ExperienceEditor(), animated: true)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Experiences Found"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Use the add experience button to create your first experience!"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage.fontAwesomeIcon(name: .sunO, textColor: GlobalConst.menuItemColor, size: CGSize(width: 70, height: 70))
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        let str = "Refresh"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout),
                     NSForegroundColorAttributeName: GlobalConst.vengaWatermelon]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.refreshData()
    }
    
    func refreshData() {
        self.loading.start(view: self.view)
        self.backend.getHostExperiences { experiences, error in
            // setup the empty dataset
            self.tableView.emptyDataSetSource = self
            self.tableView.emptyDataSetDelegate = self
            
            if let error = error {
                NSLog(error.localizedDescription)
                self.loading.stop()
                return
            }
            self.hostExperiences = experiences!
            self.tableView.reloadData()
            self.loading.stop()
        }
    }
}
