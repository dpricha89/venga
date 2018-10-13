//
//  BaseTableController.swift
//  Venga
//
//  Created by David Richards on 6/21/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import TTGSnackbar

class BaseTableController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    // shared libs
    let loading = Loading()
    let cache = Cache.sharedInstance
    let backend = Backend.sharedClient
    let alerter = Alerter()
    let refreshController = UIRefreshControl()
    let user = User.sharedInstance.user
    let snackbar = TTGSnackbar.init(message: "Message", duration: .middle)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup table
        self.setupTable()
        
        // This is needed for the auto cell height cells
        tableView.estimatedRowHeight = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // This ensures that the auto sizing of the description cell works.
        // This is a bug and should be revisited
        self.tableView.reloadData()
    }

    func setupTable(){
        // set the background
        self.tableView.backgroundColor = GlobalConst.backgroundColor
        // setup the table
        self.tableView.separatorStyle = .none
        self.tableView.register(DestinationCell.self, forCellReuseIdentifier: "DestinationCell")
        self.tableView.register(TripCell.self, forCellReuseIdentifier: "TripCell")
        self.tableView.register(UserImageCell.self, forCellReuseIdentifier: "UserImageCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.register(DestinationCell.self, forCellReuseIdentifier: "DestinationCell")
        self.tableView.register(DescriptionCell.self, forCellReuseIdentifier: "DescriptionCell")
        self.tableView.register(ExperienceCell.self, forCellReuseIdentifier: "ExperienceCell")
        self.tableView.register(IconRow.self, forCellReuseIdentifier: "IconRow")
        self.tableView.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")        
        self.tableView.register(DetailsCell.self, forCellReuseIdentifier: "DetailsCell")
        self.tableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        self.tableView.register(MapCell.self, forCellReuseIdentifier: "MapCell")
        self.tableView.register(SlideshowCell.self, forCellReuseIdentifier: "SlideshowCell")
        self.tableView.register(BasicImageCell.self, forCellReuseIdentifier: "BasicImageCell")
        self.tableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        self.tableView.register(AboutHostCell.self, forCellReuseIdentifier: "AboutHostCell")
        
        //self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
