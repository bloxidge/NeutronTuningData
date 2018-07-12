//
//  SysexParser.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 09/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

extension Array where Element == UInt8 {
    
    var dataToSysex: [UInt8] {
        var sysex: [UInt8] = []
        var overflowByte: UInt8 = 0
        
        // Pad array with zeros until to reach an array size multiple of 7
        let data = self + Array(repeating: 0, count: 7 - (self.count % 7))
        
        for (i, byte) in data.enumerated() {
            sysex.append(byte & 0x7F)
            let msb = byte >> 7
            overflowByte |= msb << (i % 7)
            if i > 0, ((i+1) % 7) == 0 {
                sysex.append(overflowByte)
                overflowByte = 0
            }
        }
        return sysex
    }
    
    var sysexToData: [UInt8] {
        guard self.allSatisfy({ $0 >> 7 == 0 }) else {
            fatalError("Array contains invalid byte(s). All bytes must be 7-bit.")
        }
        guard self.count % 8 == 0 else {
            fatalError("Sysex encoded bytes must be in groups of 8.")
        }
        
        let data = self.split(every: 8)
            .map { (byteGroup) -> [UInt8] in
                var bytes: [UInt8] = byteGroup
                let overflowByte = bytes.removeLast()
                for (i, byte) in bytes.enumerated() {
                    let msb = (Int(overflowByte) & (1 << i)) << (7 - i)
                    bytes[i] = (byte | UInt8(msb))
                }
                return bytes
            }
            .flatMap { $0 }
            .removing(suffix: 0)
        
        return data
    }
}
