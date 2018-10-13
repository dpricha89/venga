//
//  StripePayment.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

//
//  PaymentViewController.swift
//  TenderloinProject
//
//  Created by David Richards on 2/26/17.
//  Copyright © 2017 DRI Technologies LLC. All rights reserved.
//

import UIKit
import Stripe
import SnapKit
import ChameleonFramework
import SwiftDate
import FSCalendar

class StripePayment: BaseController,  STPPaymentContextDelegate {
    
    // public
    public var paymentDestination: String!
    public var experience: Experience!
    
    // msc sizes
    var centeredX: CGFloat!
    var centeredButtonX: CGFloat!
    var screenSize: CGRect!
    var inputPadding: CGFloat =  2
    
    // inputs
    var paymentTypeInput = UIView()
    var paymentTypeLabel = PaymentRow()
    var totalLabel = VengaLabel()
    var sendButton = UIButton()
    var paymentLabel = UILabel()
    var creditCard = CreditCard()
    var stepLabel = VengaStepLabel()
    var mathLabel = VengaLabel()
    var disclaimerLabel = VengaLabel()
    
    // stripe params
    var paymentContext: STPPaymentContext!
    
    init() {
        self.paymentContext = STPPaymentContext(apiAdapter: Backend.sharedClient)
        let userInformation = STPUserInformation()
        self.paymentContext.prefilledInformation = userInformation
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        self.paymentContext.hostViewController = self
        self.paymentContext.paymentAmount = 5000 // This is in cents, i.e. $50 USD
        self.paymentContext.configuration.additionalPaymentMethods = .all
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add inputs
        addPaymentTypeInput()
        addAmountInput()
        addSendButton()
        
        // setup the background
        self.view.backgroundColor = GlobalConst.backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Setup the gradient color
        self.creditCard.backgroundColor = GradientColor(UIGradientStyle.leftToRight, frame: self.creditCard.bounds, colors: [FlatMint(), FlatBlue()])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPaymentTypeInput() {
        
        // Add the step label
        self.view.addSubview(self.stepLabel)
        self.stepLabel.text = "Step 3 of 3"
        self.stepLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(GlobalConst.topPadding)
            make.height.equalTo(GlobalConst.labelHeight)
            make.centerX.equalTo(self.view)
        }
        
        // Add payment type label
        self.paymentLabel.text = "Payment"
        self.paymentLabel.textColor = .white
        self.paymentLabel.font = .boldSystemFont(ofSize: 20)
        self.view.addSubview(self.paymentLabel)
        self.paymentLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.stepLabel.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.labelHeight)
        }
        
        // Add the credit card
        self.view.addSubview(self.creditCard)
        self.creditCard.cardName.text = user?.fullname()
        self.creditCard.editCardButton.addTarget(self, action: #selector(self.changePaymentClick), for: .touchUpInside)
        self.creditCard.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(200)
            make.top.equalTo(self.paymentLabel.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset - 15)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset + 15)
        }
    }
    
    func addAmountInput() {
        
        self.view.addSubview(self.mathLabel)
        self.mathLabel.font = .systemFont(ofSize: 15, weight: UIFontWeightThin)
        self.mathLabel.text = "\(self.cache.paymentModel.prettyPrice()) (experience cost) x \(self.cache.paymentModel.groupSize.description) (group size)"
        self.mathLabel.textAlignment = .center
        self.mathLabel.snp.makeConstraints { (make) -> Void in
            make.size.height.equalTo(GlobalConst.buttonHeight)
            make.top.equalTo(self.creditCard.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
        }
        
        
        self.totalLabel.font = .systemFont(ofSize: 20, weight: UIFontWeightThin)
        self.totalLabel.textColor = .white
        self.totalLabel.text = "Total: " + self.cache.paymentModel.prettyTotal()
        self.totalLabel.textAlignment = .center
        self.view.addSubview(self.totalLabel)
        self.totalLabel.snp.makeConstraints { (make) -> Void in
            make.size.height.equalTo(GlobalConst.buttonHeight)
            make.top.equalTo(self.mathLabel.snp.bottom).offset(GlobalConst.smallTopOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
        }
    }
    
    func addSendButton() {
        self.sendButton.setTitle("Submit booking", for: .normal)
        self.sendButton.addTarget(self, action: #selector(self.sendPayment), for: .touchUpInside)
        // set color to green
        self.sendButton.backgroundColor = GlobalConst.vengaWatermelon
        self.sendButton.layer.cornerRadius = GlobalConst.cornerRadius
        self.view.addSubview(self.sendButton)
        self.sendButton.snp.makeConstraints { (make) -> Void in
            make.size.height.equalTo(GlobalConst.buttonHeight)
            make.top.equalTo(self.totalLabel.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
        }
        
        self.view.addSubview(self.disclaimerLabel)
        self.disclaimerLabel.font = .systemFont(ofSize: 15, weight: UIFontWeightThin)
        self.disclaimerLabel.text = "Your card will not be charged until the host has accepted the booking."
        self.disclaimerLabel.textColor = .gray
        self.disclaimerLabel.numberOfLines = 0
        self.disclaimerLabel.sizeToFit()
        self.disclaimerLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.sendButton.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
        }
    }
    
    func changePaymentClick() {
        NSLog("Change payment click")
        self.paymentContext.pushPaymentMethodsViewController()
    }
    
    func sendPayment(){
        NSLog("Requesting payment")
        // convert to Int then convert to cents
        self.paymentContext.paymentAmount = Int(self.cache.paymentModel.total() * 100)
        // finally send the payment request
        self.paymentContext.requestPayment()
    }
    
    // MARK: STPPaymentContextDelegate
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        NSLog("Payment context changed")
        self.sendButton.isEnabled = paymentContext.selectedPaymentMethod != nil
        if let paymentTitle = paymentContext.selectedPaymentMethod?.label {
            self.creditCard.updateTitle(cardTitle: paymentTitle)
            self.creditCard.cardImage.image = paymentContext.selectedPaymentMethod?.image
        }
    }
    
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didCreatePaymentResult paymentResult: STPPaymentResult,
                        completion: @escaping STPErrorBlock) {
        self.loading.start(view: self.view)
        self.backend.completeCharge(paymentResult, amount: self.paymentContext.paymentAmount) { (result: Any, error: Error?) in
            
            if let error = error {
                self.loading.stop()
                completion(error)
            } else {
                // convert the date so we can parse it easily in the other languages
                // iso 8601 date format
                let isoDate = self.cache.paymentModel.date.string(format: .iso8601(options: [.withInternetDateTime]))
                // create the trip in the backend so we can display and track
                self.backend.createTrip(experienceId: self.experience.id,
                                           destinationId: self.experience.destinationId,
                                           price: self.cache.paymentModel.total().description,
                                           date: isoDate,
                                           groupSize: self.cache.paymentModel.groupSize,
                                           stripeResponse: result) { result, error in
                    if (error != nil) {
                        self.loading.stop()
                        completion(nil)
                    } else {
                        self.loading.stop()
                        NSLog(error?.localizedDescription ?? "")
                        completion(error)
                    }
                }
            }
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        self.loading.stop()
        switch status {
        case .error:
            alerter.error("There was an error processing your payment", view: self.view)
        case .success:
            self.cache.didCompletePayment = true
            self.cache.completePaymentMsg = "Successful booking request"
            _ = self.navigationController?.popToRootViewController(animated: true)
        case .userCancellation:
            alerter.error("There was an error processing your payment", view: self.view)
            return
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        NSLog("Failed to load didFailToLoadWithError")
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            _ = self.navigationController?.popViewController(animated: true)
        })
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.paymentContext.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }

}
