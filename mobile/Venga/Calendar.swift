//
//  Calendar.swift
//  Venga
//
//  Created by David Richards on 7/25/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import FSCalendar
import SnapKit
import ChameleonFramework
import Material

class Calendar: BaseController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar = FSCalendar()
    var dateLabel = UILabel()
    var nextButton = FABButton(image: UIImage.fontAwesomeIcon(name: .arrowRight, textColor: .white, size: CGSize(width: 25, height: 25)))
    var stepLabel = VengaStepLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup calendar
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        
        self.view.addSubview(self.stepLabel)
        self.stepLabel.text = "Step 1 of 3"
        self.stepLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(GlobalConst.topPadding)
            make.height.equalTo(GlobalConst.labelHeight)
            make.centerX.equalTo(self.view)
        }
        
        self.dateLabel.text = "Date"
        self.dateLabel.textColor = .white
        self.dateLabel.font = .boldSystemFont(ofSize: 20)
        self.view.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.stepLabel.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view).offset(GlobalConst.leftOffset)
            make.right.equalTo(self.view).offset(GlobalConst.rightOffset)
            make.height.equalTo(GlobalConst.labelHeight)
        }
        
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.appearance.titleSelectionColor = .black
        self.calendar.appearance.titleDefaultColor = .white
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.8
        self.calendar.appearance.todayColor = GlobalConst.vengaWatermelon
        self.view.addSubview(self.calendar)
        self.calendar.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(GlobalConst.topOffset)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(300)
        }

        self.view.addSubview(self.nextButton)
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = GlobalConst.vengaWatermelon
        self.nextButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
        self.nextButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view).offset(-80)
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.centerX.equalTo(self.view)
        }
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.cache.paymentModel.date = date
        self.nextButton.isEnabled = true
    }
    
    func nextScreen() {
        self.navigationController?.pushViewController(GroupSize(), animated: true)
    }
}

