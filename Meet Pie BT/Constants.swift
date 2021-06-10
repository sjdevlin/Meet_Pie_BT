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
//    static let MeetPieCBUUID = CBUUID(string: "00000001-1E3D-FAD4-74E2-97A033F1BFEE")
    static let MeetPieCBUUID = CBUUID(string: "00000001-1E3C-FAD4-74E2-97A033F1BFAA")
    static let MeetPieDataCBUUID = CBUUID(string: "00000002-1E3C-FAD4-74E2-97A033F1BFAA")
    static let MeetPieDataNotifyCBUUID = CBUUID(string: "00000003-1E3C-FAD4-74E2-97A033F1BFAA")
//    static let MeetPieDataNotifyCBUUID = CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
//    static let BTServiceName = "Nordic SPP Counter"
    static let BTServiceName = "MeetPieBT"

}

