//
//  SysexCodingTest.swift
//  SysexCodingTest
//
//  Created by Peter Bloxidge on 09/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import XCTest

class SysexCodingTest: XCTestCase {
    
    let exampleData: [UInt8] = [
        240,   0,  32,  50,  40, 127,  10,
        15, 205,  52,  86, 120, 183, 137,
        11, 111, 222,  76, 174,  69, 205,
        162, 163, 237, 205,  95, 203, 101,
        234, 176, 247
    ]
    let exampleSysex: [UInt8] = [         // Overflow byte
        112,   0,  32,  50,  40, 127,  10,   1,
        15,  77,  52,  86, 120,  55,   9,  98,
        11, 111,  94,  76,  46,  69,  77,  84,
        34,  35, 109,  77,  95,  75, 101,  47,
        106,  48, 119,   0,   0,   0,   0,   7
    ]
    
    func testSysexEncoding() {
        XCTAssert(exampleData.dataToSysex == exampleSysex)
    }
    
    func testSysexDecoding() {
        XCTAssert(exampleSysex.sysexToData == exampleData)
    }
    
    func testSysexEncodingAndDecoding() {
        var randomBytes = [UInt8](repeating: 0, count: 169)
        randomBytes = randomBytes.map { _ in
            return UInt8(arc4random() >> 24)
        }
        
        XCTAssert(exampleData.dataToSysex.sysexToData == exampleData)
        
        XCTAssert(randomBytes.dataToSysex.sysexToData == randomBytes)
    }
}
