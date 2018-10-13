//
//  Alerter.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//
import UIKit
import JGProgressHUD
import FontAwesome_swift

class Alerter: NSObject {
    
    /*
     * @brief adds an error alert to the view
     * @param msg: error message to display
     * @param view: view to add the alert to
     */
    func error (_ msg: String, view: UIView) {
        // create a new alert view and add it to the view
        let progressHud = JGProgressHUD()
        progressHud.indicatorView = JGProgressHUDErrorIndicatorView.init()
        progressHud.animation = JGProgressHUDFadeZoomAnimation.init()
        progressHud.position = JGProgressHUDPosition.bottomCenter
        progressHud.textLabel.text = msg
        progressHud.show(in: view)
        progressHud.dismiss(afterDelay: GlobalConst.alertDelay)
    }
    
    /*
     * @brief adds a success alert to the view
     * @param msg: message to display
     * @param view: view to add the alert to
     */
    func success (_ msg: String, view: UIView) {
        // create a new alert view and add it to the view
        let progressHud = JGProgressHUD()
        progressHud.indicatorView = JGProgressHUDSuccessIndicatorView.init()
        progressHud.animation = JGProgressHUDFadeZoomAnimation.init()
        progressHud.position = JGProgressHUDPosition.bottomCenter
        progressHud.textLabel.text = msg
        progressHud.show(in: view)
        progressHud.dismiss(afterDelay: GlobalConst.alertDelay)
    }
}
