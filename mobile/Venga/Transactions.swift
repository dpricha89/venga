//
//  HistoryViewController.swift
//  Venga
//
//  Created by David Richards on 7/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit

class Transactions: BaseTableController {

    var transactions = [StripeTransaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
        let transaction = self.transactions[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.text = "\(transaction.prettyPrice()) \(transaction.status) \(transaction.created)"
        cell.textLabel?.textColor = .white
        return cell
    }
}
