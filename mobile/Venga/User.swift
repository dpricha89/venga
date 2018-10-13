//
//  User.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

class User {
    static var sharedInstance = User()
    private init() {}
    
    var user: UserModel!
}
