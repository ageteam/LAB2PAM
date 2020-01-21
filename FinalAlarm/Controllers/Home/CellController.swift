//
//  CellController.swift
//  FinalAlarm
//
//  Created by Cristian on 1/9/19.
//  Copyright © 2019 notACompany. All rights reserved.
//

import UIKit
import RealmSwift

extension AlarmTableViewCell {
    
    @IBAction func didChange(_ sender: UISwitch) {
        
        if let item = try! Realm().objects(Alarm.self).filter("Id = '\(alarmUuid)'").first{
            
            if sender.isOn {
                addAlarmToUN(alarm: item)
            }else {
                removeAlarmFromUN(alarm: item)
            }
        }
    }
}
