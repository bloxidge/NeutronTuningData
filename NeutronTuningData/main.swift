//
//  main.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 03/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

let messageHandler = MessageHandler()

let globalRequestMessage: [UInt8] = [0xF0, 0x00, 0x20, 0x32, 0x28, 0x7F, 0x05, 0xF7]

// Send keep-alive messaage every second
while (true) {
    sleep(1);
    MIDIEngine.instance.sendMessage(globalRequestMessage)
}
