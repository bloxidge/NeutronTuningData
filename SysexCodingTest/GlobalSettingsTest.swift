//
//  GlobalSettingsTest.swift
//  SysexCodingTest
//
//  Created by Peter Bloxidge on 27/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import XCTest
@testable import NeutronTuningData

class GlobalSettingsTest: XCTestCase {
    
    let globalSettingsResponse = Message(type: .system(.exclusive),
                                         data: [0xF0, 0x00, 0x20, 0x32, 0x28, 0x00, 0x06, 0x01,
                                                0x08, 0x01, 0x00, 0x00, 0x02, 0x31, 0x09, 0x58,
                                                0x46, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x40, 0xF7])
    let expectedParameters: [ParameterType : Any] = [
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
        .LFO_MIDI_SYNC     : false,
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

    func testParseGlobalSettings() {
        guard let globalSettingsResponse = NeutronMessage(globalSettingsResponse) else {
            XCTFail("globalSettingsResponse is not a NeutronMessage")
            return
        }
        
        XCTAssert(globalSettingsResponse.sysexCommand == .globalSettingResponse)
        
        let strippedData = Array(globalSettingsResponse.data[NeutronMessage.header.count+3..<globalSettingsResponse.data.count-1])
        let globalSettings = GlobalSettings(packed: strippedData.sysexToData)
        
        XCTAssert(globalSettings.parameters.keys == expectedParameters.keys)
        
        globalSettings.parameters.map {
            XCTAssertNotNil(expectedParameters[$0.key])
            let expectedValue = expectedParameters[$0.key]
            
            XCTAssert($0.value == expectedValue)
        }
    }
}
