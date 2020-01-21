//
//  LabelViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 1/9/19.
//  Copyright © 2019 notACompany. All rights reserved.
//

import UIKit

extension LabelViewController {
    
    @IBAction func didEdit(_ sender: UITextField) {
        if sender.text?.isEmpty ?? true {
            self.alarm.label = "Alarm"
        }else{
            self.alarm.label = sender.text!
        }
    }
}
