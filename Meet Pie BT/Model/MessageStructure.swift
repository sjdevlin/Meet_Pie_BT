//
//  MessageStructure.swift
//  Meet Pie BT
//
//  Created by Stephen Devlin on 09/02/2021.
//

import Foundation

struct MessageStructure: Decodable {

//    var    timeStamp: Int = 0
    var    tMT: Int = 0
    var    m: [Main] = []

    struct Main: Decodable {
        var mN: Int = 0
        var a: Int = 0
        var t: Int = 0
        var nT: Int = 0
        var f: Int = 0
        var tT: Int = 0
    }
}

