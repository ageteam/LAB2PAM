//
//  AddEditController.swift
//  FinalAlarm
//
//  Created by Cristian on 1/9/19.
//  Copyright © 2019 notACompany. All rights reserved.
//

import UIKit
import RealmSwift

extension AddEditViewController {
    
    @IBAction func CancelButton(_ sender: UIBarButtonItem) {
        alarmUuid = nil
        localAlarm = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SaveButton(_ sender: UIBarButtonItem) {
        
        let realm = try! Realm()
        let alarm = realm.objects(Alarm.self).filter("Id = '\(alarmUuid ?? "")'").first
        
        var calendar = Calendar.current
        let year = calendar.component(.year, from: dateYearpickerOutlet.date)
        let month = calendar.component(.month, from: dateYearpickerOutlet.date)
        let day = calendar.component(.day, from: dateYearpickerOutlet.date)
        
        let hour = calendar.component(.hour, from: DatePickerOutlet.date)
        let minute = calendar.component(.minute, from: DatePickerOutlet.date)
        let second = calendar.component(.second, from: DatePickerOutlet.date)
        
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        
        localAlarm!.time = calendar.date(from: components)!
        
        if alarm != nil {
            removeAlarmFromUN(alarm: alarm!)//remove the old alarm/s if exists
        }
        addAlarmToUN(alarm: localAlarm)//add the new alarm/s
        
        if !(newAlarm ?? true) {//if the alarm is not new
            
            try! realm.write {
                
                if alarm != nil {//update the entity from realm
                    alarm!.Id = localAlarm!.Id
                    //alarm!.isOn = localAlarm!.isOn
                    alarm!.time = localAlarm!.time
                    alarm!.label = localAlarm!.label
                    alarm!.repeatDays.removeAll()
                    for day in localAlarm!.repeatDays {
                        alarm!.repeatDays.append(day)
                    }
                    alarm!.songName = localAlarm!.songName
                }
            }
        } else {
            try! realm.write {
                realm.add(localAlarm)//add entitty to realm
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
//        case 0:
//            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RepeatVC") as? RepeatTableViewController {
//                if let navigator = navigationController {
//                    viewController.alarm = self.localAlarm
//                    navigator.pushViewController(viewController, animated: true)
//                }
//            }
        case 0:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LabelVC") as? LabelViewController {
                if let navigator = navigationController {
                    viewController.alarm = self.localAlarm
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        case 1:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SoundVC") as? SoundTableViewController {
                if let navigator = navigationController {
                    viewController.alarm = self.localAlarm
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        default:
            print("Fail to push from options table")
        }
    }
}
