//
//  ViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/17/18.
//  Copyright © 2018 notACompany. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var alarmsTable: UITableView!
    
    var alarms = [Alarm]()
    var systemNotifications = [UNNotificationRequest]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentGroup = DispatchGroup()
        refreshActiveNotifications(outerGroup: currentGroup)
        currentGroup.notify(queue: .main) {
            let realm = try! Realm()
            self.alarms = Array(realm.objects(Alarm.self))
            self.alarmsTable.tableFooterView = UIView()
            self.alarmsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alarmsTable.allowsSelectionDuringEditing = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillAppear(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options:
        [.sound, .alert, .badge]) { (didAllow, error) in
            if error == nil {
                //print("Allowed")
            }
        }
        alarmsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseAlarm", for: indexPath) as! AlarmTableViewCell
        
        let alarm = alarms[indexPath.row]
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        let timeDate = dateFormater.string(from: alarm.time)
        
        let dateFormaterday = DateFormatter()
        dateFormaterday.dateFormat = "dd/MM/yyyy"
        let date = dateFormaterday.string(from: alarm.time)
        cell.switch4.isOn = isAlarmOn(alarm)
        cell.time1.text = "\(timeDate)"
        cell.label3.text = "\(date), \(alarm.label)"
        cell.alarmUuid = alarm.Id
        
        return cell
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}



