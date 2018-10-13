//
//  ResetPassword.swift
//  Venga
//
//  Created by David Richards on 7/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SnapKit

class ResetPassword: BaseController {
    
    let previousPasswordField = VengaField()
    let newPasswordField = VengaField()
    let confirmNewPasswordField = VengaField()
    let submitButton = VengaButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        self.view.addSubview(self.previousPasswordField)
        self.previousPasswordField.placeholder = "Current password"
        self.previousPasswordField.isSecureTextEntry = true
        self.previousPasswordField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(GlobalConst.topPadding)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        self.view.addSubview(self.newPasswordField)
        self.newPasswordField.placeholder = "New password"
        self.newPasswordField.isSecureTextEntry = true
        self.newPasswordField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.previousPasswordField.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        self.view.addSubview(self.confirmNewPasswordField)
        self.confirmNewPasswordField.placeholder = "Confirm"
        self.confirmNewPasswordField.isSecureTextEntry = true
        self.confirmNewPasswordField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.newPasswordField.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
        
        self.view.addSubview(self.submitButton)
        self.submitButton.backgroundColor = GlobalConst.loginButtonColor
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        self.submitButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.confirmNewPasswordField.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.buttonHeight)
        }
    }
    
    func submit() {
        if (self.newPasswordField.text == self.confirmNewPasswordField.text && (self.previousPasswordField.text != nil)) {
           print("Sending password to be reset")
            self.backend.reset(self.newPasswordField.text!, currentPassword: self.previousPasswordField.text!) { error in
                if let error = error {
                    NSLog(error.localizedDescription)
                    self.snackbar.message = "There was an error updating your password"
                    self.snackbar.show()
                    return
                }
                self.snackbar.message = "Successful reset"
                self.snackbar.show()
            }
        } else {
            self.snackbar.message = "The new passwords do not match"
            self.snackbar.show()
        }
    }
}
