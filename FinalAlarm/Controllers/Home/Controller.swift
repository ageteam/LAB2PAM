//
//  Controller.swift
//  FinalAlarm
//
//  Created by Cristian on 1/9/19.
//  Copyright © 2019 notACompany. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

extension ViewController {
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEdit") as? AddEditViewController {
            if let navigator = navigationController {
                viewController.newAlarm = true
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    @IBAction func editBtn(_ sender: UIBarButtonItem) {
        self.alarmsTable.setEditing(!self.alarmsTable.isEditing, animated: true)
        sender.title = (self.alarmsTable.isEditing) ? "Done" : "Edit"
    }
    
    //Checking if the Alarm is curentlu registered to UserNotifications
    func isAlarmOn(_ alarm: Alarm) -> Bool{
        var isON: Bool? = nil
        if alarm.repeatDays.count == 0 {
            let alarmsFound = systemNotifications.filter{ $0.identifier == alarm.Id }.count
            if alarmsFound > 0 {
                isON = true
            }else{
                isON = false
            }
        }else {
            var totalAlarms = 0
            for dayNumber in alarm.repeatDays {
                let alarmsFound = systemNotifications.filter{ $0.identifier == "\(dayNumber)+\(alarm.Id)" }.count
                if alarmsFound > 0 {
                    totalAlarms += 1
                }
            }
            if totalAlarms == alarm.repeatDays.count {
                isON = true
            }else {
                isON = false
            }
        }
        return isON!
    }
    
    func refreshActiveNotifications(outerGroup: DispatchGroup){
        
        systemNotifications = [UNNotificationRequest]()//clear current Notifications
        let center = UNUserNotificationCenter.current()
        
        outerGroup.enter()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for item in requests {
                self.systemNotifications.append(item)//appending All Future Notifications
            }
            //print("Total Active notif found: \(self.systemNotifications.count)")
            outerGroup.leave()
            return
        })
    }
    
    //Selecting In Edit Mode
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.alarmsTable.isEditing {
            self.alarmsTable.isEditing = false
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEdit") as? AddEditViewController {
                if let navigator = navigationController {
                    viewController.newAlarm = false
                    viewController.alarmUuid = alarms[indexPath.row].Id
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    //Deleting in Edit Mode
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            try! realm.write {
                removeAlarmFromUN(alarm: alarms[indexPath.row])
                realm.delete(alarms[indexPath.row])
                alarms.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
