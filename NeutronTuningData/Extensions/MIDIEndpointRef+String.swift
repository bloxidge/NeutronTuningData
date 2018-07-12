//
//  MIDIEndpointRef+String.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 06/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation
import CoreMIDI

extension MIDIEndpointRef {
    var displayName: String {
        var param: Unmanaged<CFString>?
        var name: String?
        
        if MIDIObjectGetStringProperty(self, kMIDIPropertyDisplayName, &param) == OSStatus(noErr) {
            name = param!.takeRetainedValue() as String
        }
        return name ?? "(No Device found at Endpoint)"
    }
}
