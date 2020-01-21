//
//  RepeatTableViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/20/18.
//  Copyright © 2018 notACompany. All rights reserved.
//

import UIKit

class RepeatTableViewController: UITableViewController {

    var alarm: Alarm! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repeatDay", for: indexPath)

        let title = cell.viewWithTag(1) as! UILabel
        title.text = "Every \(daysDictionary[indexPath.row]!.rawValue)"
        
        if alarm.repeatDays.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        }
        return cell
    }
}
