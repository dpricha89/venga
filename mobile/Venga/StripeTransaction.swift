//
//  StripeTransaction.swift
//  Venga
//
//  Created by David Richards on 7/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

struct StripeTransaction {
    var id: String
    var status: String
    var amount: Float
    var created: String
}

extension StripeTransaction {
    func prettyPrice() -> String {
        return "$" + Int(amount).description
    }
}
