//
//  GlobalConst.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import ChameleonFramework
import Stripe


struct GlobalConst {
    
    // messages
    static let successMessage = "SUCCESS"
    static let failureMessage = "FAILURE"
    
    // labels
    static let logoutLabel: String = "Logout"
    static let transactionLabel: String = "Transactions"
    
    // hud
    static let alertDelay: TimeInterval = 3.0
    
    // screen names
    static let people: String = "Homeless"
    static let resources: String = "Resources"
    static let account: String = "Account"
    static let outreach: String = "Outreach"
    
    // login type
    static let coinbaseLoginType: String = "coinbase"
    static let facebookLoginType: String = "facebook"
    
    // notification key name
    static let notificationName: String = "changeView"
    static let notificationKey: String = "message"
    
    // loigin notification key name
    static let loginNotificationName: String = "changeLoginView"
    
    // images
    static let backgroundImageName = "bright-scales.png"
    static let logoImageSquare = "square.png"
    static let logoImageRect = "rectagle.png"
    
    // Venga color scheme
    static let vengaDark: UIColor = UIColor.init(hexString: "14103B")!
    static let vengaWatermelon: UIColor = UIColor.init(hexString: "F02A71")!
    static let vengaLightBlue: UIColor = UIColor.init(hexString: "7EC0E4")!
    static let vengaBlue: UIColor = UIColor.init(hexString: "6789BA")!
    
    // colors
    static let backgroundColor: UIColor = vengaDark
    static let facebookButtonColor: UIColor = FlatBlue()
    static let signupButtonColor: UIColor = FlatWatermelon()
    static let loginButtonColor: UIColor = vengaBlue
    static let loginInputOutline: UIColor = FlatGray()
    static let menuItemColor: UIColor = vengaLightBlue
    static let logoutLabelColor: UIColor = .black
    static let clipboardButtonColor: UIColor = FlatTeal()
    static let coinbaseButtonColor: UIColor = FlatSkyBlue()
    static let amountLabelColor: UIColor = FlatTealDark()
    static let vengaFieldForgroundColor: UIColor = FlatGray()
    static let selectedIconColor: UIColor = vengaWatermelon
    static let destinationTitleColor: UIColor = .white
    static let sectionLineColor: UIColor = .white
    static let sectionTitleColor: UIColor = .white
    static let buttonTextColor: UIColor = .white
    static let stripeErrorColor: UIColor = FlatWatermelon()
    static let secondaryBackgroundColor: UIColor = FlatBlack()
    
    // sizes
    static let buttonWidth: CGFloat = 280.0
    static let buttonHeight: CGFloat = 40.0
    static let leftViewWidth: CGFloat = 180
    static let contentViewScale: CGFloat = 0.90
    static let accountImageWidth: CGFloat = 80.0
    static let smallMenuImageSize: CGFloat = 60.0
    static let cornerRadius: CGFloat = 5.0
    static let borderWidth: CGFloat = 1.0
    static let labelHeight: CGFloat = 20
    static let logoHeight: CGFloat = 130
    static let topPadding: CGFloat = 80.0
    static let rowHeight: CGFloat = 60.0
    static let amountHeight: CGFloat = 50.0
    static let leftOffset: CGFloat = 60.0
    static let rightOffset: CGFloat = -60.0
    static let topOffset: CGFloat = 30.0
    static let labelOffset: CGFloat = 1
    static let loginOffset: CGFloat = 10.0
    static let spacingOffset: CGFloat = 10.0
    static let homelessDetailImageWidth: CGFloat = 140.0
    static let smallLeftOffset: CGFloat = 20.0
    static let smallTopOffset: CGFloat = 5.0
    static let smallLabelHeight: CGFloat = 15
    static let smallRightOffset: CGFloat = -20.0
    static let smallBottomOffset: CGFloat = -5.0
    static let lockImageSize: CGFloat = 80
    static let titleLeftOffset: CGFloat = 30
    static let paymentImageWidth: CGFloat = 60
    static let paymentImageHeight: CGFloat = 40
    static let paymentTypeHeight: CGFloat = 75
    static let toolbarHeight: CGFloat = 60
    static let largeLabelhieght: CGFloat = 28
    static let profileImageHeight: CGFloat = 140.0
    static let profileImageWidth: Float = 140.0
    
    // api gateway constants
    static let apiDomain: String = "qc1fkjmrf5.execute-api.us-west-2.amazonaws.com"
    
    // stage constants
    static let stage: String = "dev"
    
    // users constants
    static let userUri: String = "/\(stage)/accounts"
    static let userUrl: String = "https://\(apiDomain)\(userUri)"
    static let userLoginUrl: String = "\(userUrl)/login"
    static let userSignupUrl: String = "\(userUrl)/signup"
    static let userMeUrl: String = "\(userUrl)/me"
    static let userResetUrl: String = "\(userUrl)/reset"
    
    // destination constants
    static let destinationUri: String = "/\(stage)/destinations"
    static let destinationUrl: String = "https://\(apiDomain)\(destinationUri)"
    
    // stripe constants
    static let stripeUri: String = "/\(stage)/customer"
    static let stripeUrl: String = "https://\(apiDomain)\(stripeUri)"
    static let stripeUrlDefaultSource: String = "\(stripeUrl)/default_source"
    static let stripeUrlSources: String = "\(stripeUrl)/sources"
    static let stripeUrlCharge: String = "\(stripeUrl)/charge"
    static let stripeUrlCharges: String = "\(stripeUrl)/charges"
    static let stripeTheme: STPTheme = .default()
    static let stripeOauthTokenUrl = "https://connect.stripe.com/oauth/token"
    static let stripeClientIdMap = [
    "dev": "ca_B7w0Z9Rmzwtv7ZeBPHvA3hXMv86P1YtP",
    "prod": ""
    ]
    static let stripePublisherKeyMap = [
        "dev": "pk_test_RJR3QGsLr3VlcauydNJvtoD5",
        "prod": ""
    ]
    static let stripeSecretKeyMap = [
        "dev": "sk_test_EINMwhftuBdW3dTc78In8e0f",
        "prod": ""
    ]
    static let stripeSecretKey = stripeSecretKeyMap[stage]!
    static let stripePublisherKey = stripePublisherKeyMap[stage]!
    static let stripeClientId = stripeClientIdMap[stage]!
    
    // trips constants
    static let tripsUri: String = "/\(stage)/trips"
    static let tripsUrl: String = "https://\(apiDomain)\(tripsUri)"
    
    // reviews constants
    static let reviewUri: String = "/\(stage)/reviews"
    static let reviewUrl: String = "https://\(apiDomain)\(reviewUri)"
    
    // facebook constants
    static let facebookUserParameters: [String: Any] = ["fields": "email, first_name, last_name, picture.type(large)"]
    static let facebookMe: String = "/me"
    
    // hosts constants
    static let hostUri: String = "/\(stage)/hosts"
    static let hostUrl: String = "https://\(apiDomain)\(hostUri)"
    static let hostExperiencesUrl: String = "https://\(apiDomain)\(hostUri)/experiences"
    
    // images constants
    static let imagesUri: String = "/\(stage)/images"
    static let imagesUrl: String = "https://\(apiDomain)\(imagesUri)"
    static let imagesPreSignedUrls: String = "\(imagesUrl)/urls"
    
    // experience constants
    static let experienceUri: String = "/\(stage)/experience"
    static let experienceUrl: String = "https://\(apiDomain)\(experienceUri)"
    static let createExperienceUrl: String = "\(experienceUrl)/create"
}


