//
//  Trips.swift
//  
//
//  Created by David Richards on 6/15/17.
//
//

import UIKit
import Alamofire
import AlamofireImage
import DZNEmptyDataSet
import SwiftDate

class Trips: BaseTableController {
    
    var trips = [Trip]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the refresh controller target
        self.refreshController.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // this makes the images show up under the status bar.
        // Without this setting there would be a little black bar at the
        // top where the clock and other status items go.
        self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 45, 0)
        // get the trip data
        self.getTripData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trip = trips[indexPath.row]
        // Instantiate a cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TripCell") as! TripCell
        cell.tripTitle.text = trip.experience?.title
        // convert the iso 8601 date back to date object
        var formatedDate = "N/A"
        do {
            formatedDate = trip.date.string(dateStyle: .short, timeStyle: .none)
        } catch let error {
            print(error.localizedDescription)
        }
        cell.tripDate.text = "Date: " + formatedDate
        cell.tripStatus.text = "Status: " + trip.status
        // set the image of the experience
        if let imageUrl = trip.experience?.images.first?.url {
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
    
    func getTripData() {
        self.loading.start(view: self.view)
        self.backend.getTrips { results, error in
            // setup the empty dataset
            self.tableView.emptyDataSetSource = self
            self.tableView.emptyDataSetDelegate = self
            // stop the spinner
            self.loading.stop()
            // check for errors
            if (error != nil) {
                NSLog((error?.localizedDescription)!)
                self.tableView.reloadData()
            } else {
                // got the trips
                self.trips = results!
                // now reload the table
                self.tableView.reloadData()
            }
        }
    }
    
    func refresh(sender:AnyObject) {
        self.getTripData()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Trips Found"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Use the explore section to book your next adventure!"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage.fontAwesomeIcon(name: .plane, textColor: GlobalConst.menuItemColor, size: CGSize(width: 70, height: 70))
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        let str = "Refresh"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout),
                     NSForegroundColorAttributeName: GlobalConst.vengaWatermelon]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.getTripData()
    }

}
