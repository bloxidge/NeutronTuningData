//
//  GlobalSettings.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 27/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

struct GlobalSettings {
    
    private let blocks: [UInt16]
    
    var parameters: [ParameterType : Any] = [
        .OSC1_BLEND_MODE   : false,
        .OSC1_TUNE_POT     : false,
        .OSC1_RANGE        : 0,
        .OSC2_BLEND_MODE   : false,
        .OSC2_TUNE_POT     : false,
        .OSC2_RANGE        : 0,
        .OSC_KEY_SPLIT     : 0,
        .OSC_SYNC          : false,
        .PARAPHONIC_MODE   : false,
        .LFO_BLEND_MODE    : false,
        .LFO_KEY_SYNC      : false,
        .LFO_ONE_SHOT      : 0,
        .LFO_DEPTH         : 0,
        .LFO_KEY_TRACK     : false,
//        .KEY_TRACK_ROOT    : 24,
        .LFO_MIDI_SYNC     : false,
//        .LFO_MOD_SRC       : 0,
        .LFO_SHAPE_ORDER   : [0, 1, 2, 3, 4],
        .LFO_PHASE_OFFSET  : [0, 0, 0, 0, 0],
        .VCF_KEY_TRACK     : false,
        .VCF_MOD_SRC       : 0,
        .VCF_MODE          : 0,
        .MIDI_CHANNEL      : 0,
        .DISABLE_MIDI_DIPS : false,
        .POLYCHAIN_MODE    : false,
        .NOTE_PRIORITY     : 0,
        .PITCH_BEND_RANGE  : 2,
        .ENV_RETRIGGER     : false,
        .ASSIGN_OUT        : 0,
        .KEY_RANGE_MUTE    : false,
        .KEY_RANGE_MIN     : 24,
        .KEY_RANGE_MAX     : 96
    ]
    
    init(packed bytes: [UInt8]) {
        blocks = bytes.toUInt16Array()
        
        for parameter in parameters {
            let descriptor = parameter.key.layoutDescription
            let bitMask = UInt16((1 << descriptor.size) - 1)
            let rawValue = (blocks[descriptor.memoryBlock] >> descriptor.offset) & bitMask
            
            switch parameters[parameter.key] {
            case is Bool:
                parameters[parameter.key] = rawValue == 1
            case var array as Array<Int>:
                let elementSize = descriptor.size / array.count
                let bitMask = UInt16((1 << elementSize) - 1)
                for i in 0..<array.count {
                    array[i] = Int((rawValue >> UInt8(elementSize * i)) & bitMask)
                }
                parameters[parameter.key] = array
            default:
                parameters[parameter.key] = rawValue
            }
        }
    }
    
    func printParameters() {
        for (key, value) in parameters.sorted(by: { ParameterType.all.index(of: $0.key)! < ParameterType.all.index(of: $1.key)! }) {
            print("\(key) : \(value)")
        }
    }
}

extension FixedWidthInteger {
    var binaryString: String {
        var result: [String] = []
        for i in 0..<(Self.bitWidth / 8) {
            let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
            let byteString = String(byte, radix: 2)
            let padding = String(repeating: "0",
                                 count: 8 - byteString.count)
            result.append(padding + byteString)
        }
        return result.reversed().joined().inserting(separator: " ", every: 1)
    }
}
