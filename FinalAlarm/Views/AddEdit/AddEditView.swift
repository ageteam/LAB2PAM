//
//  AddEditViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/18/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import RealmSwift
import UIKit

class AddEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var optionsTable: UITableView!
    @IBOutlet weak var DatePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var dateYearpickerOutlet: UIDatePicker!
    var newAlarm: Bool?
    var alarmUuid: String? = nil
    var localAlarm: Alarm! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.optionsTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DatePickerOutlet.setValue(UIColor.white, forKey: "textColor")
        self.DatePickerOutlet.setValue(true, forKey: "highlightsToday")
        
        self.dateYearpickerOutlet.setValue(UIColor.white, forKey: "textColor")
        self.dateYearpickerOutlet.setValue(true, forKey: "highlightsToday")
        
        if newAlarm ?? false {
            localAlarm = Alarm()
        } else {
            let realm = try! Realm()
            let alarm = realm.objects(Alarm.self).filter("Id = '\(alarmUuid ?? "")'").first
            if alarm != nil {
                localAlarm = Alarm()
                localAlarm!.Id = alarm!.Id
                //localAlarm!.isOn = alarm!.isOn
                localAlarm!.time = alarm!.time
                localAlarm!.label = alarm!.label
                localAlarm.repeatDays.removeAll()
                for day in alarm!.repeatDays {
                    localAlarm.repeatDays.append(day)
                }
                localAlarm.songName = alarm!.songName
            }else {
                localAlarm = Alarm()
                alarmUuid = localAlarm.Id
                newAlarm = true
            }
        }
        self.DatePickerOutlet.date = localAlarm.time
        self.dateYearpickerOutlet.date = localAlarm.time
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreSettings", for: indexPath) //as! AlarmTableViewCell
        switch indexPath.row {
//        case 0:
//            let repeatCell = cell.viewWithTag(1) as! UILabel
//            repeatCell.text = "Repeat"
//
//            let array = Array(localAlarm!.repeatDays)
//            let repeatValue = cell.viewWithTag(2) as! UILabel
//            repeatValue.text = getShortRepeatDays(array: array)
//            return cell
        case 0:
            let label = cell.viewWithTag(1) as! UILabel
            label.text = "Label"
            
            let labelValue = cell.viewWithTag(2) as! UILabel
            labelValue.text = localAlarm!.label
            return cell
        case 1:
            let soundCell = cell.viewWithTag(1) as! UILabel
            soundCell.text = "Sound"
            
            let soundValue = cell.viewWithTag(2) as! UILabel
            soundValue.text = soundsDictionary[localAlarm.songName]!.rawValue
            return cell
        default:
            return UITableViewCell()
        }
    }
}
