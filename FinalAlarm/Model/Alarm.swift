//
//  AlarmModel.swift
//  FinalAlarm
//
//  Created by Cristian on 12/18/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import RealmSwift

class Alarm: Object{
    //@objc dynamic var isOn: Bool = true
    @objc dynamic var time: Date = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
    @objc dynamic var songName: Int = 0
    @objc dynamic var label: String = "Alarm"
    @objc dynamic var Id: String = UUID.init().uuidString
    var repeatDays = List<Int>()
}



