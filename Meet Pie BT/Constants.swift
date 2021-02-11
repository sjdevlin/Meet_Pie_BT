//
//  Constants.swift
//  Meet Pie BT
//
//  Created by Stephen Devlin on 09/02/2021.
//

import Foundation
import CoreBluetooth

struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "BlueCell"
    static let MeetPieCBUUID = CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
    static let MeetPieDataCBUUID = CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
    static let MeetPieDataNotifyCBUUID = CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
    static let BTServiceName = "Nordic SPP Counter"
}

