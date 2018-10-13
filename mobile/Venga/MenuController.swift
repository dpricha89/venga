//
//  MenuController.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import LGSideMenuController

class MenuController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the left bar item
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as Dictionary!
        let lefty = UIBarButtonItem(title: String.fontAwesomeIcon(name: .bars), style: .plain, target: self, action: #selector(openLeft))
        lefty.setTitleTextAttributes(attributes, for: UIControlState())
        self.navigationItem.leftBarButtonItem = lefty
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openLeft() {
        NSLog("Opening left")
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }

}
