//
//  RepeatTableViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 1/9/19.
//  Copyright © 2019 notACompany. All rights reserved.
//

import UIKit

extension RepeatTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.alarm.repeatDays.contains(indexPath.row) {
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.alarm.repeatDays.append(indexPath.row)
        }else{
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if let index = alarm.repeatDays.firstIndex(of: indexPath.row){
                self.alarm.repeatDays.remove(at: index)
            }
        }
    }
}
