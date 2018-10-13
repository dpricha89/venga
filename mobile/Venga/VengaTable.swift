//
//  VengaTable.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

class VengaTable: UITableView {

    override public func layoutSubviews() {
        super.layoutSubviews()
        defaultSettings()
    }
    
    private func defaultSettings() {
        self.backgroundColor = .clear
    }
}
