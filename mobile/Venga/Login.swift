//
//  Login.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit
import FacebookLogin
import LGSideMenuController

class Login: InputController {
    
    // buttons
    var facebookButton = VengaButton()
    var loginButton = VengaButton()
    var signupButton = VengaButton()
    
    // inputs
    var passwordInput = VengaField()
    var usernameInput = VengaField()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        // Add username input
        self.usernameInput.placeholder = "Email"
        self.usernameInput.keyboardType = .emailAddress
        self.usernameInput.autocapitalizationType = .none
        self.view.addSubview(self.usernameInput)
        self.usernameInput.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(GlobalConst.topPadding)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        // Add password input
        self.passwordInput.placeholder = "Password"
        self.passwordInput.isSecureTextEntry = true
        self.view.addSubview(self.passwordInput)
        self.passwordInput.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(self.usernameInput.snp.bottom).offset(GlobalConst.loginOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        // add login button
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.backgroundColor = GlobalConst.loginButtonColor
        self.loginButton.layer.cornerRadius = GlobalConst.cornerRadius
        self.loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        self.view.addSubview(loginButton)
        self.loginButton.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(self.passwordInput.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        // add signup button
        self.signupButton.setTitle("Signup", for: .normal)
        self.signupButton.backgroundColor = GlobalConst.vengaWatermelon
        self.signupButton.addTarget(self, action: #selector(self.signupButtonClicked), for: .touchUpInside)
        self.view.addSubview(signupButton)
        self.signupButton.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(self.loginButton.snp.bottom).offset(GlobalConst.loginOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        // add facebook login
        // Add a custom faceook login button
        self.facebookButton.backgroundColor = GlobalConst.facebookButtonColor
        self.facebookButton.setTitle("Facebook Login", for: .normal)
        self.facebookButton.addTarget(self, action: #selector(self.facebookButtonClicked), for: .touchUpInside)
        self.view.addSubview(facebookButton)
        self.facebookButton.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(self.signupButton.snp.bottom).offset(GlobalConst.loginOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
    }
    
    func login() {
        // start the loader
        self.loading.start(view: self.view)
        self.backend.login(self.usernameInput.text, password: self.passwordInput.text) { userAccount, error in
            //stop the loader
            self.loading.stop()
            // if there was an error show the user
            if (error != nil) {
                self.snackbar.message = "Error logging user in"
                self.snackbar.show()
                return
            }
            // assign user to the singleton class
            User.sharedInstance.user = userAccount
            
            // create views
            self.present(NaviProvider.customBouncesStyle(), animated: true)
        }
    }
    
    func signupButtonClicked() {
        self.present(Signup(), animated: true)
    }
    
    // Once the button is clicked, show the login dialog
    func facebookButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                
                // after successful login set the login type
                Realm().setLoginType("facebook")
                
                // login to the backend
                self.login()
                
            }
        }
    }

}
