//
//  SoundTableViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 1/9/19.
//  Copyright © 2019 notACompany. All rights reserved.
//

import UIKit

extension SoundTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.visibleCells[alarm.songName].accessoryType = .none  //Remove CheckMark from previous selected Song
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark    //Adding CheckMark to new selected Song
        self.alarm.songName = indexPath.row
    }
}
