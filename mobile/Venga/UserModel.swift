//
//  UserModel.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//
import UIKit
import SwiftyJSON

class UserModel {
    
    var firstname: String!
    var lastname: String!
    var email: String!
    var imageUrl: String = "https://c.disquscdn.com/next/embed/assets/img/noavatar92.7b2fde640943965cc88df0cdee365907.png"
    var token: String!
    var isFacebook = false
    var facebookId = ""
    var isHost = false
    var hostId: String?
    
    init(json: JSON) {
        self.firstname = json["firstname"].stringValue
        self.lastname = json["lastname"].stringValue
        self.email = json["email"].stringValue
        self.imageUrl = json["imageUrl"].stringValue
        self.token = json["token"].stringValue
        self.facebookId = json["facebook_id"].stringValue
        self.isFacebook = json["facebook_id"].boolValue
        self.isHost = json["is_host"].boolValue
        self.hostId = json["host_id"].stringValue
    }
}


extension UserModel {
    func fullname() -> String {
        return firstname + " " + lastname
    }
}
