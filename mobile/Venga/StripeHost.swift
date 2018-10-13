//
//  StripeHost.swift
//  Venga
//
//  Created by David Richards on 8/3/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SwiftyJSON

struct StripeHost {
    var obj: JSON
    
    func toDict() -> [String: String]{
        return [
            "stripe_user_id": self.obj["stripe_user_id"].stringValue,
            "stripe_publishable_key": self.obj["stripe_publishable_key"].stringValue,
            "token_type": self.obj["token_type"].stringValue,
            "refresh_token": self.obj["refresh_token"].stringValue,
            "livemode": self.obj["livemode"].stringValue,
            "access_token": self.obj["access_token"].stringValue,
            "scope": self.obj["scope"].stringValue
        ]
    }
    
    init(json: JSON) {
        self.obj = json
    }
}
