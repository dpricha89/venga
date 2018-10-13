//
//  Realm.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import CoreData


class Realm: NSObject {
    
    
    let defaults = UserDefaults.standard
    
    func clearData() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

    
    func setLoginType (_ type: String) {
        defaults.set(type, forKey: "loginType")
    }
    
    func loginType () -> String {
        return defaults.string(forKey: "loginType") ?? ""
    }

    
    func saveCoinbaseToken (_ token: String) {
        defaults.setValue(token, forKey: "coinbaseToken")
    }
    
    func getCoinbaseToken () -> String? {
        return defaults.string(forKey: "coinbaseToken")
    }
    
    func saveCoinbaseRefreshToken (_ token: String) {
        defaults.setValue(token, forKey: "coinbaseRefreshToken")
    }
    
    func getCoinbaseRefreshToken () -> String? {
        return defaults.string(forKey: "coinbaseRefreshToken")
    }
    
    func saveToken (_ token: String) {
        defaults.setValue(token, forKey: "token")
    }
    
    func getToken () -> String {
        return defaults.string(forKey: "token") ?? ""
    }
    
    func saveCurrentView(_ view: String) {
        defaults.setValue(view, forKey: "currentView")
    }
    
    func getCurrentView() -> String {
        return defaults.string(forKey: "currentView") ?? ""
    }
    
}
