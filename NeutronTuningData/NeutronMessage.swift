//
//  NeutronMessage.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 09/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

enum SysexCommand: UInt8 {
    case globalSettingRequest  = 0x05
    case globalSettingResponse = 0x06
    case parameterSet          = 0x0A
    case parameterSetResponse  = 0x5A
    case restoreGlobalSettings = 0x0B
    case calibrationMode       = 0x10
    case tuningRequest         = 0x71
    case tuningResponse        = 0x72
    case versionRequest        = 0x73
    case versionResponse       = 0x74
    case factoryReset          = 0x77
}

class NeutronMessage: Message {
    static let header: [UInt8] = [0xF0, 0x00, 0x20, 0x32, 0x28]
    
    var deviceID: UInt8 {
        return data[NeutronMessage.header.count]
    }
    var sysexCommand: SysexCommand {
        let commandByte = data[NeutronMessage.header.count + 1]
        return SysexCommand(rawValue: commandByte)!
    }
    
    init?(_ message: Message) {
        guard message.isNeutronMessage else { return nil }
        super.init(type: message.type, data: message.data)
    }
    
}

extension Message {
    var isNeutronMessage: Bool {
        return Array(data[0..<NeutronMessage.header.count]) == NeutronMessage.header
    }
}
