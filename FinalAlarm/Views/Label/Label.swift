//
//  LabelViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/19/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import UIKit

class LabelViewController: UIViewController {

    @IBOutlet weak var editLabel: UITextField!

    var alarm: Alarm! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editLabel.text = alarm.label
    }
}
