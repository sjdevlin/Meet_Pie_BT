//
//  MessageStructure.swift
//  Meet Pie BT
//
//  Created by Stephen Devlin on 09/02/2021.
//

import Foundation

struct MessageStructure: Decodable {

    var    timeStamp: Int = 0
    var    totalMeetingTime: Int = 0
    var    message: [Main] = []

    struct Main: Decodable {
        var memNum: Int = 0
        var angle: Int = 0
        var talking: Int = 0
        var numTurns: Int = 0
        var freq: Int = 0
        var totalTalk: Int = 0
    }
}

