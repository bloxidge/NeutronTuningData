//
//  MessageType.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 06/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

enum MessageType {
    case channel(ChannelMessageType)
    case system(SystemMessageType)
}

enum ChannelMessageType {
    case noteOff
    case noteOn
    case keyPressure
    case controlChange
    case programChange
    case channelPressure
    case pitchBend
}

enum SystemMessageType {
    case exclusive
    case timeCode
    case songPositionPointer
    case songSelect
    case tuneRequest
    case timingClock
    case startSequence
    case continueSequence
    case stopSequence
    case activeSense
    case reset
}

extension MessageType {
    var size: Int? {
        switch self {
        case .channel(.noteOff), .channel(.noteOn), .channel(.keyPressure),
             .channel(.controlChange), .channel(.pitchBend),
             .system(.songPositionPointer):
            return 3
        case .channel(.programChange), .channel(.channelPressure),
             .system(.timeCode), .system(.songSelect):
            return 2
        case .system(.tuneRequest), .system(.timingClock), .system(.startSequence),
             .system(.continueSequence), .system(.stopSequence), .system(.activeSense),
             .system(.reset):
            return 1
        case .system(.exclusive):
            return nil
        }
    }
}

extension MessageType: RawRepresentable {
    
    typealias RawValue = UInt8
    
    init?(rawValue: UInt8) {
        let msb = rawValue >> 4
        let lsb = rawValue & 0xF
        
        if msb == 0xF { // Is a system message
            var systemMessageType: SystemMessageType
            switch lsb {
            case 0x0: systemMessageType = .exclusive
            case 0x1: systemMessageType = .timeCode
            case 0x2: systemMessageType = .songPositionPointer
            case 0x3: systemMessageType = .songSelect
            case 0x6: systemMessageType = .tuneRequest
            case 0x8: systemMessageType = .timingClock
            case 0xA: systemMessageType = .startSequence
            case 0xB: systemMessageType = .continueSequence
            case 0xC: systemMessageType = .stopSequence
            case 0xE: systemMessageType = .activeSense
            case 0xF: systemMessageType = .reset
            default:
                return nil
            }
            self = .system(systemMessageType)
        }
        else { // Is a channel message
            var channelMessageType: ChannelMessageType
            switch msb {
            case 0x8: channelMessageType = .noteOff
            case 0x9: channelMessageType = .noteOn
            case 0xA: channelMessageType = .keyPressure
            case 0xB: channelMessageType = .controlChange
            case 0xC: channelMessageType = .programChange
            case 0xD: channelMessageType = .channelPressure
            case 0xE: channelMessageType = .pitchBend
            default:
                return nil
            }
            self = .channel(channelMessageType)
        }
    }
    
    var rawValue: UInt8 {
        switch self {
        case .channel(let channelMessageType):
            switch channelMessageType {
            case .noteOff:         return 0x80
            case .noteOn:          return 0x90
            case .keyPressure:     return 0xA0
            case .controlChange:   return 0xB0
            case .programChange:   return 0xC0
            case .channelPressure: return 0xD0
            case .pitchBend:       return 0xE0
            }
        case .system(let systemMessageType):
            switch systemMessageType {
            case .exclusive:           return 0xF0
            case .timeCode:            return 0xF1
            case .songPositionPointer: return 0xF2
            case .songSelect:          return 0xF3
            case .tuneRequest:         return 0xF6
            case .timingClock:         return 0xF8
            case .startSequence:       return 0xFA
            case .continueSequence:    return 0xFB
            case .stopSequence:        return 0xFC
            case .activeSense:         return 0xFE
            case .reset:               return 0xFF
            }
        }
    }
}

extension MessageType: CustomStringConvertible {
    var description: String {
        switch self {
        case .channel(let channelMessageType):
            switch channelMessageType {
            case .noteOff:         return "Note Off"
            case .noteOn:          return "Note On"
            case .keyPressure:     return "Key Pressure"
            case .controlChange:   return "Control Change"
            case .programChange:   return "Program Change"
            case .channelPressure: return "Channel Pressure"
            case .pitchBend:       return "Pitch Bend"
            }
        case .system(let systemMessageType):
            switch systemMessageType {
            case .exclusive:           return "SysEx"
            case .timeCode:            return "Time Code"
            case .songPositionPointer: return "Song Position Pointer"
            case .songSelect:          return "Song Select"
            case .tuneRequest:         return "Tune Request"
            case .timingClock:         return "Real-time Clock"
            case .startSequence:       return "Sequence Start"
            case .continueSequence:    return "Sequence Continue"
            case .stopSequence:        return "Sequence Stop"
            case .activeSense:         return "Active Sense"
            case .reset:               return "Reset"
            }
        }
    }
}
