//
//  LoadingView.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import FacebookCore
import LGSideMenuController
import SwiftDate

class LoadingView: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // start the spinner
        self.loading.start(view: self.view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        // check if the access token is available already
        if Realm().getToken().characters.count > 0 {
            
            // assign token to the api headers
            self.backend.headers = ["Authorization": Realm().getToken()]
            
            // make the api request to get the user profile
            self.backend.getUser() { user, error in
                
                // stop the spinner
                self.loading.stop()
                
                // if error then show login
                if error != nil {
                    // send the user the the login screen
                    self.present(Login(), animated: false)
                }
                
                // assign the user to the singleton instance to be used elsewhere
                User.sharedInstance.user = user
                
                // init the main controller
                self.present(NaviProvider.customBouncesStyle(), animated: true)
            }
            
            
        } else {
            // stop the spinner
            self.loading.stop()
            
            // send the user the the login screen
            self.present(Login(), animated: false)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
