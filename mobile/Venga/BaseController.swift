//
//  BaseController.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import TTGSnackbar

class BaseController: UIViewController {
    
    let loading = Loading()
    let cache = Cache.sharedInstance
    let backend = Backend.sharedClient
    let alerter = Alerter()
    let user = User.sharedInstance.user
    let snackbar = TTGSnackbar.init(message: "Message", duration: .middle)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the background color
        self.view.backgroundColor = GlobalConst.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
