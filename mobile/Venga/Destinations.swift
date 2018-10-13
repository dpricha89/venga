//
//  Destinations.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import DZNEmptyDataSet
import SnapKit

class Destinations: BaseTableController {
    
    // create the table
    var destinations = [Destination]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start the spinner
        self.loading.start(view: self.view)
        
        // get the data
        self.getData()
        
        // add the refresh controller target
        self.refreshController.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // this makes the images show up under the status bar.
        // Without this setting there would be a little black bar at the
        // top where the clock and other status items go.
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        
        // if returned to this view after a successful payment then show
        // details in an alert
        if cache.didCompletePayment {
            self.snackbar.message = cache.completePaymentMsg
            self.snackbar.show()
            // reset the boolean so this doesnt show every time the view appears
            cache.didCompletePayment = false
        }
        // using tabbar and toolbar causes issues when coming back to the screen
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.destinations.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDestination = self.destinations[indexPath.section]
        NSLog("Selected \(selectedDestination.title)")
        
        // start the spinner and get the experiences
        self.loading.start(view: self.view)
        backend.getExperiences(id: selectedDestination.id) { returnedExperiences, error in
            self.loading.stop()
            if (error != nil) {
                NSLog(error?.localizedDescription ?? "")
            }
            let experiencesView = ExperiencesTable()
            experiencesView.experiences = returnedExperiences
            experiencesView.destination = selectedDestination
            self.navigationController?.pushViewController(experiencesView, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // make sure the spacing is clear
        let returnedView = UIView()
        returnedView.backgroundColor = .clear
        return returnedView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let destination = self.destinations[indexPath.section]
        
        // Instantiate a cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DestinationCell") as! DestinationCell
        
        Alamofire.request(destination.imageUrl).responseImage { response in
            // get the image
            if let image = response.result.value {
                // scale the photo
                let aspectScaledToFitImage = image.af_imageAspectScaled(toFill: CGSize(width: cell.bounds.width, height: cell.bounds.height))
                // add the image to the view
                cell.backgroundView = UIImageView(image: aspectScaledToFitImage)
                // stop the spinner
                cell.spinner.stopAnimating()
                cell.spinner.removeFromSuperview()
            }
        }
        
        // add the title label
        cell.destinationTitle.text = destination.title
        
        // remove the cell selector hightlight
        cell.selectionStyle = .none;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func getData() {
        self.backend.getDestinations { destinations, error in
            // setup the empty dataset
            self.tableView.emptyDataSetSource = self
            self.tableView.emptyDataSetDelegate = self
            // stop the spinner
            self.loading.stop()
            if (error != nil) {
                return
            }
            self.destinations = destinations!
            // tell refresh control it can stop showing up now
            if (self.refreshController.isRefreshing)
            {
                self.refreshController.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
    
    func refresh(sender:AnyObject) {
        self.getData()
    }

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Missing data"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Something went wrong"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage.fontAwesomeIcon(name: .plane, textColor: GlobalConst.menuItemColor, size: CGSize(width: 70, height: 70))
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        let str = "Refresh"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.getData()
    }

}
