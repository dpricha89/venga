//
//  Cache.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

class Cache: NSObject {
    
    static var sharedInstance = Cache()
    
    // payment cache
    var didCompletePayment: Bool = false
    var completePaymentMsg: String = ""
    var paymentDestination: String = ""

    // login type
    var loginType = "default"
    
    var paymentModel = PaymentModel()
    var selectedExperience: Experience?
}

