//
//  GroupSize.swift
//  Venga
//
//  Created by David Richards on 7/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import ChameleonFramework
import Material

class GroupSize: BaseController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var groupLabel = UILabel()
    var groupRange: Array<Int> = Array(1...10)
    var groupInput = UIPickerView()
    var stepLabel = VengaStepLabel()
    let nextButton = FABButton(image: UIImage.fontAwesomeIcon(name: .arrowRight, textColor: .white, size: CGSize(width: 25, height: 25)))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUI() {
        
        self.view.addSubview(self.stepLabel)
        self.stepLabel.text = "Step 2 of 3"
        self.stepLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(GlobalConst.topPadding)
            make.height.equalTo(GlobalConst.labelHeight)
            make.centerX.equalTo(self.view)
        }

        self.view.addSubview(self.groupLabel)
        self.groupLabel.textColor = .white
        self.groupLabel.text = "Group size"
        self.groupLabel.font = .boldSystemFont(ofSize: 20)
        self.groupLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.stepLabel.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.labelHeight)
        }

        self.view.addSubview(self.groupInput)
        self.groupInput.delegate = self
        self.groupInput.dataSource = self
        self.groupInput.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.groupLabel.snp.bottom).offset(GlobalConst.smallTopOffset)
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
        }
        
        self.view.addSubview(self.nextButton)
        self.nextButton.backgroundColor = GlobalConst.vengaWatermelon
        self.nextButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
        self.nextButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view).offset(-80)
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.centerX.equalTo(self.view)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupRange.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        print(groupRange[row].description)
        let attributedString = NSAttributedString(string: groupRange[row].description, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cache.paymentModel.groupSize = groupRange[row]
    }
    
    func nextScreen() {
        if let experience = self.cache.selectedExperience {
            let stripePayment = StripePayment()
            stripePayment.experience = experience
            self.navigationController?.pushViewController(stripePayment, animated: true)
        }
    }

}
