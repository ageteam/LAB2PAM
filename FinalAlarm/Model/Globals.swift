//
//  EnumsAndDict.swift
//  FinalAlarm
//
//  Created by Cristian on 12/27/18.
//  Copyright © 2018 notACompany. All rights reserved.
//


let daysDictionary : [Int: RepeatDays] = [0:.monday, 1:.tuesday, 2:.wednesday, 3:.thursday, 4:.friday, 5:.saturday, 6:.sunday]

let soundsDictionary : [Int: Songs] = [0:.airRaid, 1:.analog, 2:.car, 3:.coltonmanz, 4:.cydon, 5:.sieuamthanh, 6:.trip, 7:.zyrytsounds]

enum RepeatDays: String{
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}


enum Songs: String {
    case airRaid = "bz1"
    case analog = "bz2"
    case car = "bz3"
    case coltonmanz = "bz4"
    case cydon = "bz5"
    case sieuamthanh = "bz6"
    case trip = "bz7"
    case zyrytsounds = "bz8"
}
