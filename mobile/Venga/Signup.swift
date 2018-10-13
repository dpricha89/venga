//
//  Signup.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class Signup: InputController {
    
    // fields and buttons
    var firstnameTextField = VengaField()
    var lastnameTextField = VengaField()
    var emailTextField = VengaField()
    var passwordTextField = VengaField()
    var passwordConfirmTextField = VengaField()
    var singupButton = VengaButton()
    var cancelButton = VengaButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the view
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        
        // first set the background to white so the labels will not overlap
        self.view.backgroundColor = GlobalConst.backgroundColor
        
        // setup the first name field with constraints
        self.firstnameTextField.placeholder = "First Name"
        self.view.addSubview(firstnameTextField)
        self.firstnameTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(60)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        // setup the last name field with contraints
        self.lastnameTextField.placeholder = "Last Name"
        self.view.addSubview(self.lastnameTextField)
        self.lastnameTextField.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.firstnameTextField)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.top.equalTo(self.firstnameTextField.snp.bottom).offset(GlobalConst.topOffset)
        }
        
        // setup the email field with contraints
        self.emailTextField.placeholder = "Email"
        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.autocapitalizationType = .none
        self.view.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.firstnameTextField)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.top.equalTo(self.lastnameTextField.snp.bottom).offset(GlobalConst.topOffset)
        }
        
        // setup the password field with contraints
        self.passwordTextField.placeholder = "Password"
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.autocapitalizationType = .none
        self.view.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.firstnameTextField)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.top.equalTo(self.emailTextField.snp.bottom).offset(GlobalConst.topOffset)
        }
        
        
        // setup the password field with contraints
        self.passwordConfirmTextField.placeholder = "Confirm Password"
        self.passwordConfirmTextField.isSecureTextEntry = true
        self.passwordConfirmTextField.autocapitalizationType = .none
        self.view.addSubview(self.passwordConfirmTextField)
        self.passwordConfirmTextField.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.firstnameTextField)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(GlobalConst.topOffset)
        }
        
        // signup button with contraints
        self.singupButton.backgroundColor = GlobalConst.vengaWatermelon
        self.singupButton.setTitle("Signup", for: .normal)
        self.singupButton.addTarget(self, action: #selector(self.signupClicked), for: .touchUpInside)
        self.view.addSubview(self.singupButton)
        self.singupButton.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.firstnameTextField)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.top.equalTo(self.passwordConfirmTextField.snp.bottom).offset(GlobalConst.topOffset)
        }
        
        // cancel button with contraints
        self.cancelButton.backgroundColor = .clear
        self.cancelButton.layer.borderWidth = GlobalConst.borderWidth
        self.cancelButton.layer.borderColor = UIColor.white.cgColor
        self.cancelButton.setTitle("Cancel", for: .normal)
        self.cancelButton.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        self.view.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints() { (make) -> Void in
            make.size.equalTo(self.singupButton)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.top.equalTo(self.singupButton.snp.bottom).offset(GlobalConst.loginOffset)
        }
    }
    
    @IBAction func signupClicked() {
        // start the loader
        self.loading.start(view: self.view)
        NSLog("Signup clicked")
        if let firstname = self.firstnameTextField.text,
            let lastname = self.lastnameTextField.text,
            let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            let passwordConfirm = self.passwordConfirmTextField.text {
            
            if firstname.isEmpty, lastname.isEmpty, email.isEmpty, password.isEmpty, passwordConfirm.isEmpty {
                self.loading.stop()
                self.snackbar.message = "All fields should be filled out"
                self.snackbar.show()
                return
            } else if (password != passwordConfirm) {
                self.loading.stop()
                self.snackbar.message = "Passwords do not match"
                self.snackbar.show()
                return
            }
            
            // send to the server
            backend.singup(firstname: firstname, lastname: lastname, email: email, password: password) { result, error in
                // stop the loader
                self.loading.stop()
                // if there was an error display it on the screen
                if (error != nil) {
                    self.alerter.error((error?.localizedDescription ?? "")!, view: self.view)
                    return
                }
                // return back to the login screen
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            self.loading.stop()
            self.snackbar.message = "All fields should be filled out"
            self.snackbar.show()
        }
    }
}
