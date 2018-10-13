//
//  Review.swift
//  Venga
//
//  Created by David Richards on 7/22/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

struct Review {
    var id = String()
    var experienceId = String()
    var name = String()
    var reviewDate = Date()
    var imageUrl = String()
    var comment = String()
    
    init(review: JSON) {
        self.id = review["id"].stringValue
        self.experienceId = review["experience_id"].stringValue
        self.name = review["name"].stringValue
        self.imageUrl = review["image_url"].stringValue
        self.comment = review["comment"].stringValue
        
        // convert the iso 8601 date back to date object
        var parsedDate = DateInRegion()
        do {
            parsedDate = try DateInRegion(string: review["review_date"].stringValue, format: .iso8601(options: .withInternetDateTime))
        } catch let error {
            print(error.localizedDescription)
        }
        self.reviewDate = parsedDate.absoluteDate
    }
}
