//
//  Trip.swift
//  Venga
//
//  Created by David Richards on 6/15/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

struct Trip {
    var accountId = String()
    var experienceId = String()
    var destinationId = String()
    var id = String()
    var price = String()
    var date = Date()
    var status = String()
    var experience: Experience?
    
    init(json: JSON) {
        self.accountId = json["account_id"].stringValue
        self.experienceId = json["experience_id"].stringValue
        self.destinationId = json["destination_id"].stringValue
        self.id = json["id"].stringValue
        self.price = json["price"].stringValue
        
        do {
            let dateOb = try DateInRegion(string: json["date"].stringValue, format: .iso8601(options: .withInternetDateTime))
            self.date = dateOb.absoluteDate
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.status = json["status"].stringValue
        self.experience = Experience(experience: json["experience"])
    }
}

