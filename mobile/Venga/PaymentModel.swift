//
//  PaymentModel.swift
//  Venga
//
//  Created by David Richards on 7/25/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

struct PaymentModel {
    var date = Date()
    var price = Float()
    var groupSize = 1
}

extension PaymentModel {
    func total() -> Float {
        return price * Float(groupSize)
    }
    
    func prettyPrice() -> String {
       return "$" + Int(price).description
    }
    func prettyTotal() -> String {
        return "$" + Int(total()).description
    }
}
