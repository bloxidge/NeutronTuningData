//
//  Message.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 06/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

class Message {
    var type: MessageType
    var data: [UInt8]
    
    init(type: MessageType, data: [UInt8] = []) {
        self.type = type
        self.data = data
    }
}
