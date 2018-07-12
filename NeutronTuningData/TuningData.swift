//
//  TuningData.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 11/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

struct TuningData {
    private let interval: UInt32
    let noteNum: UInt16
    var oscID: UInt8
    
    init(packed bytes: [UInt8]) {
        var bytes = bytes + Array(repeating: 0, count: 7 - (bytes.count % 7))
        interval = Data(bytes: bytes[0...3]).withUnsafeBytes { $0.pointee }
        noteNum = Data(bytes: bytes[4...5]).withUnsafeBytes { $0.pointee }
        oscID = bytes[6]
    }
    
    var period: TimeInterval {
        return TimeInterval(interval) / TimeInterval.microsecondsPerSecond
    }
    var frequency: Double {
        return 1 / period
    }
}

extension TuningData: CustomStringConvertible {
    var description: String {
        return "OSC \(oscID + 1) Frequency (Hz): \(frequency)"
    }
}
