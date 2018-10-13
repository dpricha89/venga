//
//  Experience.swift
//  Venga
//
//  Created by David Richards on 5/6/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Experience {
    var id = String()
    var destinationId = String()
    var title = String()
    var location = ExperienceLocation()
    var itinerary = String()
    var description = String()
    var price = Float()
    var images = [ExperienceImage]()
    var included = [String]()
    var languages = [String]()
    var details = ExperienceDetails()
    var date = "N/A"
    var hostId = String()
    
    init (experience: JSON) {
        self.id = experience["id"].stringValue
        self.destinationId = experience["destination_id"].stringValue
        self.title = experience["title"].stringValue
        self.location = ExperienceLocation(lat: experience["location"]["lat"].floatValue,
                                           lng: experience["location"]["lng"].floatValue)
        self.itinerary = experience["itinerary"].stringValue
        self.description = experience["description"].stringValue
        self.price = experience["price"].floatValue
        self.images = experience["images"].arrayValue.map { image in
            ExperienceImage(title: image["title"].stringValue,
                            url: image["url"].stringValue)
        }
        self.included = experience["included"].arrayValue.map { $0.stringValue }
        self.languages = experience["languages"].arrayValue.map { $0.stringValue }
        self.details = ExperienceDetails(style: experience["details"]["style"].stringValue,
                                         physicalRating: experience["details"]["physical_rating"].intValue,
                                         ageRequirement: experience["details"]["age_requirement"].intValue,
                                         groupSize: experience["details"]["group_size"].intValue,
                                         hours: experience["details"]["hours"].intValue)
        self.date = experience["date"].stringValue
        self.hostId = experience["host_id"].stringValue
    }
}


extension Experience {
    // Generate price
    func prettyPrice() -> String {
        return "$" + self.price.description.components(separatedBy: ".")[0]
    }
    
    func prettyDuration() -> String {
        if (details.hours > 24) {
            return "\(Int(details.hours / 24)) days"
        } else {
            return "\(details.hours) hours"
        }
    }
}
