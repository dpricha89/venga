//
//  NaviProvider.swift
//  Venga
//
//  Created by David Richards on 4/30/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class NaviProvider: NSObject {

    static func customBouncesStyle() -> Navi {
        let tabBarController = ESTabBarController()
        
        // init and choose the icon for each page
        let v1 = Destinations()
        let v2 = Trips()
        let v3 = Account()
        v1.tabBarItem = ESTabBarItem.init(BounceView(), title: "Explore", image: UIImage.fontAwesomeIcon(name: .search, textColor: .green, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.fontAwesomeIcon(name: .search, textColor: .green, size: CGSize(width: 30, height: 30)))
        v2.tabBarItem = ESTabBarItem.init(BounceView(), title: "Trips", image: UIImage.fontAwesomeIcon(name: .plane, textColor: .white, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.fontAwesomeIcon(name: .plane, textColor: GlobalConst.vengaWatermelon, size: CGSize(width: 30, height: 30)))
        v3.tabBarItem = ESTabBarItem.init(BounceView(), title: "Account", image: UIImage.fontAwesomeIcon(name: .user, textColor: .white, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.fontAwesomeIcon(name: .user, textColor: GlobalConst.vengaWatermelon, size: CGSize(width: 30, height: 30)))
        
        // style the tab bar
        tabBarController.viewControllers = [v1, v2, v3]
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.shadowImage = nil
        tabBarController.tabBar.backgroundColor = GlobalConst.vengaDark
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.barTintColor = GlobalConst.vengaDark

        // init the root view in the navigation view
        let navigationController = Navi.init(rootViewController: tabBarController)
        // return the navigation controller
        return navigationController
    }
    
}
