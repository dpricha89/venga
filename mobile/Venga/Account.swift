//
//  Account.swift
//  Venga
//
//  Created by David Richards on 6/22/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Account: BaseTableController {
    
    let rowCount = 6

    override func viewDidLoad() {
        super.viewDidLoad()

        // add the refresh controller target
        self.refreshController.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        self.navigationController?.isToolbarHidden = true
        // this makes the images show up under the status bar.
        // Without this setting there would be a little black bar at the
        // top where the clock and other status items go.
        self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 45, 0)
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
        return self.user!.isFacebook ? self.rowCount - 1 : self.rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Instantiate a cell
        if (indexPath.row == 0) {
           let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserImageCell") as! UserImageCell
            // set the image of the user
            if let facebookId = user?.facebookId {
                let facebookProfileUrl = "https://graph.facebook.com/\(facebookId)/picture?type=large"
                Alamofire.request(facebookProfileUrl).responseImage { response in
                    // get the image
                    if let image = response.result.value {
                        // add the image to the view as a rounded image
                        cell.userImage.image = image.af_imageRoundedIntoCircle()
                    } else {
                        cell.userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: .white, size: CGSize(width: 40, height: 40))
                    }
                }
            } else {
                cell.userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: .white, size: CGSize(width: 40, height: 40))
            }
           return cell
        } else {
            
            // these are basic rows with just simple text
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "Default")!
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.selectionStyle = .none
            
            // determine indexpath
            if (indexPath.row == 1) {
                cell.textLabel?.text = "Payment History"
            } else if (indexPath.row == 2) {
                cell.textLabel?.text = "Logout"
            } else if (indexPath.row == 3) {
                if (self.user?.isHost)! {
                    cell.textLabel?.text = "Host menu"
                } else {
                    cell.textLabel?.text = "Become a host"
                }
            } else if (indexPath.row == 4) {
                cell.textLabel?.text = "Support"
            } else if (indexPath.row == 5) {
                cell.textLabel?.text = "Change Password"
            }
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1) {
            self.backend.getCharges { transactions, error in
                if let error = error {
                    NSLog(error.localizedDescription)
                    return
                }
                let transactionView = Transactions()
                transactionView.transactions = transactions!
                self.navigationController?.pushViewController(transactionView, animated: true)
            }
        } else if (indexPath.row == 2) {
            // Clear all user data from the device
            Realm().clearData()
            // send the user the the login screen
            self.present(Login(), animated: true)
        } else if (indexPath.row == 3){
            // Push to the stripe setup
            if (self.user?.isHost)! {
                NSLog("Should open the user menu")
                self.navigationController?.pushViewController(MyExperiences(), animated: true)
            } else {
                let url = "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_B7w0Z9Rmzwtv7ZeBPHvA3hXMv86P1YtP&scope=read_write"
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            }
        } else if (indexPath.row == 4) {
            print("Pushing to email app")
            // Open the email app with the support email
            UIApplication.shared.open(URL(string: "mailto:admin@venga.co")!, options: [:], completionHandler: nil)
        } else if (indexPath.row == 5) {
            self.navigationController?.pushViewController(ResetPassword(), animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 190
        } else {
            return 80
        }
    }
    
    func refresh(sender:AnyObject) {
        self.refreshController.endRefreshing()
    }
}
