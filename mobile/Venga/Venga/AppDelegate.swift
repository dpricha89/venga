//
//  AppDelegate.swift
//  Venga
//
//  Created by David Richards on 4/12/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import FacebookCore
import Stripe
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup stripes
        STPPaymentConfiguration.shared().publishableKey = GlobalConst.stripePublisherKey
        STPPaymentConfiguration.shared().appleMerchantIdentifier = "merchant.com.venga.Venga"
        STPPaymentConfiguration.shared().companyName = "Venga Inc"
        STPPaymentConfiguration.shared().requiredBillingAddressFields = .zip
        STPPaymentConfiguration.shared().additionalPaymentMethods = .all
        STPPaymentConfiguration.shared().smsAutofillDisabled = false
        
        // setup the stripe theme
        STPTheme.default().accentColor = GlobalConst.menuItemColor
        STPTheme.default().primaryBackgroundColor = GlobalConst.backgroundColor
        STPTheme.default().errorColor = GlobalConst.stripeErrorColor
        STPTheme.default().secondaryBackgroundColor = GlobalConst.secondaryBackgroundColor
        STPTheme.default().primaryForegroundColor = GlobalConst.buttonTextColor
        STPTheme.default().secondaryForegroundColor = GlobalConst.loginInputOutline
        
        // make the clock and status white
        UIApplication.shared.statusBarStyle = .lightContent
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            window.backgroundColor = UIColor.white
            window.rootViewController = LoadingView()
            window.makeKeyAndVisible()
        }
        return SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        if (url.scheme == "venga-stripe-redirect") {
            let backend = Backend.sharedClient
            // Get the url code value from the oauth redirect
            let code = url.absoluteURL.valueOf(queryParamaterName: "code")
            if let code = code {
                backend.stripeOauthToken(client_secret: GlobalConst.stripeSecretKey, code: code) { json, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    backend.signupHost(stripeHost: StripeHost(json: json)) { error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        User.sharedInstance.user.isHost = true
                    }
                }
            }
        
            return true
        } else {
            return SDKApplicationDelegate.shared.application(
                app,
                open: url as URL!,
                sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,
                annotation: options[UIApplicationOpenURLOptionsKey.annotation]
            )
        }
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return SDKApplicationDelegate.shared.application(
            application,
            open: url as URL!,
            sourceApplication: sourceApplication,
            annotation: annotation
        )
    }

}

// This gives me the mothod to get query string values
extension URL {
    func valueOf(queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}

