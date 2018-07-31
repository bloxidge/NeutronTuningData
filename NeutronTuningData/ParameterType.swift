//
//  ParameterType.swift
//  NeutronTuningDataTests
//
//  Created by Peter Bloxidge on 27/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

enum ParameterType: String {
    case OSC1_RANGE
    case OSC2_RANGE
    case OSC_SYNC
    case LFO_KEY_SYNC
    case VCF_KEY_TRACK
    case PARAPHONIC_MODE
    case VCF_MODE
    case ASSIGN_OUT
    case OSC1_BLEND_MODE
    case OSC2_BLEND_MODE
    case LFO_BLEND_MODE
    case ENV_RETRIGGER
    case OSC1_TUNE_POT
    case OSC2_TUNE_POT
    case POLYCHAIN_MODE
    case DEVICE_ID
    case MIDI_CHANNEL
    case DISABLE_MIDI_DIPS
    case NOTE_PRIORITY
    case PITCH_BEND_RANGE
    case OSC1_AUTOGLIDE
    case OSC2_AUTOGLIDE
    case LFO_SHAPE_ORDER
    case LFO_MIDI_SYNC
    case LFO_KEY_TRACK
    case LFO_DEPTH
    case OSC_KEY_SPLIT
    case LFO_PHASE_OFFSET
    case KEY_RANGE_MUTE
    case KEY_RANGE_MIN
    case KEY_RANGE_MAX
    case VCF_MOD_SRC
    case LFO_ONE_SHOT
    
    static var all: [ParameterType] = [
        .OSC1_RANGE,
        .OSC2_RANGE,
        .OSC_SYNC,
        .LFO_KEY_SYNC,
        .VCF_KEY_TRACK,
        .PARAPHONIC_MODE,
        .VCF_MODE,
        .ASSIGN_OUT,
        .OSC1_BLEND_MODE,
        .OSC2_BLEND_MODE,
        .LFO_BLEND_MODE,
        .ENV_RETRIGGER,
        .OSC1_TUNE_POT,
        .OSC2_TUNE_POT,
        .POLYCHAIN_MODE,
        .DEVICE_ID,
        .MIDI_CHANNEL,
        .DISABLE_MIDI_DIPS,
        .NOTE_PRIORITY,
        .PITCH_BEND_RANGE,
        .OSC1_AUTOGLIDE,
        .OSC2_AUTOGLIDE,
        .LFO_SHAPE_ORDER,
        .LFO_MIDI_SYNC,
        .LFO_KEY_TRACK,
        .LFO_DEPTH,
        .OSC_KEY_SPLIT,
        .LFO_PHASE_OFFSET,
        .KEY_RANGE_MUTE,
        .KEY_RANGE_MIN,
        .KEY_RANGE_MAX,
        .VCF_MOD_SRC,
        .LFO_ONE_SHOT
    ]
}

typealias ParameterLayoutDescription = (memoryBlock: Int, offset: Int, size: Int)

extension ParameterType {
    var layoutDescription: ParameterLayoutDescription {
        switch self {
        case .OSC1_RANGE:        return (memoryBlock: 0, offset: 0, size: 2)
        case .OSC2_RANGE:        return (memoryBlock: 0, offset: 2, size: 2)
        case .OSC_SYNC:          return (memoryBlock: 0, offset: 4, size: 1)
        case .LFO_KEY_SYNC:      return (memoryBlock: 0, offset: 5, size: 1)
        case .VCF_KEY_TRACK:     return (memoryBlock: 0, offset: 6, size: 1)
        case .PARAPHONIC_MODE:   return (memoryBlock: 0, offset: 7, size: 1)
        case .VCF_MODE:          return (memoryBlock: 0, offset: 8, size: 2)
        case .ASSIGN_OUT:        return (memoryBlock: 0, offset: 10, size: 3)
        case .OSC1_BLEND_MODE:   return (memoryBlock: 0, offset: 13, size: 1)
        case .OSC2_BLEND_MODE:   return (memoryBlock: 0, offset: 14, size: 1)
        case .LFO_BLEND_MODE:    return (memoryBlock: 0, offset: 15, size: 1)
        
        case .ENV_RETRIGGER:     return (memoryBlock: 1, offset: 0, size: 1)
        case .OSC1_TUNE_POT:     return (memoryBlock: 1, offset: 1, size: 1)
        case .OSC2_TUNE_POT:     return (memoryBlock: 1, offset: 2, size: 1)
        case .POLYCHAIN_MODE:    return (memoryBlock: 1, offset: 3, size: 2)
        case .DEVICE_ID:         return (memoryBlock: 1, offset: 5, size: 4)
        case .MIDI_CHANNEL:      return (memoryBlock: 1, offset: 9, size: 4)
        case .DISABLE_MIDI_DIPS: return (memoryBlock: 1, offset: 13, size: 1)
        case .NOTE_PRIORITY:     return (memoryBlock: 1, offset: 14, size: 2)
        
        case .PITCH_BEND_RANGE:  return (memoryBlock: 2, offset: 0, size: 5)
        case .OSC1_AUTOGLIDE:    return (memoryBlock: 2, offset: 5, size: 5)
        case .OSC2_AUTOGLIDE:    return (memoryBlock: 2, offset: 10, size: 5)
        
        case .LFO_SHAPE_ORDER:   return (memoryBlock: 3, offset: 0, size: 15)
        case .LFO_MIDI_SYNC:     return (memoryBlock: 3, offset: 15, size: 1)
        
        case .LFO_KEY_TRACK:     return (memoryBlock: 4, offset: 0, size: 7)
        case .LFO_DEPTH:         return (memoryBlock: 4, offset: 7, size: 3)
        case .OSC_KEY_SPLIT:     return (memoryBlock: 4, offset: 10, size: 6)
        
        case .LFO_PHASE_OFFSET:  return (memoryBlock: 5, offset: 0, size: 15)
        case .KEY_RANGE_MUTE:    return (memoryBlock: 5, offset: 15, size: 1)
        
        case .KEY_RANGE_MIN:     return (memoryBlock: 6, offset: 0, size: 6)
        case .KEY_RANGE_MAX:     return (memoryBlock: 6, offset: 6, size: 6)
        case .VCF_MOD_SRC:       return (memoryBlock: 6, offset: 12, size: 2)
        case .LFO_ONE_SHOT:      return (memoryBlock: 6, offset: 14, size: 2)
        }
    }
}

extension ParameterType: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}
