//
//  MessageHandler.swift
//  Neutron Tuning Data
//
//  Created by Peter Bloxidge on 06/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation
import CoreMIDI

protocol MessageHandlerDelegate {
    func messageHandler(didReceiveBytes bytes: [UInt8], fromSource source: MIDIEndpointRef)
}

class MessageHandler: MessageHandlerDelegate {
    
    private var tempBytes: [UInt8] = []
    private var tempMessageType: MessageType = .system(.exclusive)
    private let sysexEndByte: UInt8 = 0xF7
    
    init() {
        MIDIEngine.instance.delegate = self
    }
    
    /**
     * Handle incoming MIDI packets.
     * Packets may be split so this function should be used to stitch together split packages and form Message objects.
     */
    func messageHandler(didReceiveBytes bytes: [UInt8], fromSource source: MIDIEndpointRef) {
        for byte in bytes {
            // Check if byte is a status byte since packets can get split
            if (byte >> 7) == 1 {
                // It's possible a SysEx message gets split and the end byte comes in on its own...
                guard byte != sysexEndByte else {
                    tempBytes.append(byte)
//                    print("From \(source.displayName):\t\(tempMessageType)\t\(tempBytes.hexDescription)")
                    handleMessage(Message(type: tempMessageType, data: tempBytes))
                    return
                }
                // Clear the byte array for new message
                tempBytes.removeAll()
                // Set message type from status byte
                guard let tempMessageType = MessageType(rawValue: byte) else {
                    fatalError("Status Byte not recognised!")
                }
                self.tempMessageType = tempMessageType
            }
            
            // Add the byte to the constructed message
            tempBytes.append(byte)
            
            // Create message when byte count reaches expected size for message type
            if tempBytes.count == tempMessageType.size || byte == sysexEndByte {
//                print("From \(source.displayName):\t\(tempMessageType)\t\(tempBytes.hexDescription)")
                handleMessage(Message(type: tempMessageType, data: tempBytes))
            }
        }
    }
    
    func handleMessage(_ message: Message) {
        // Only care about SysEx messages
        if message.type == .system(.exclusive) {
            // See if message is a Neutron message
            guard let neutronMessage = NeutronMessage(message) else { return }
            // Only care about tuning data responses
            if neutronMessage.sysexCommand == .tuningResponse {
                parseTuningResponse(neutronMessage)
            }
        }
    }
    
    func parseTuningResponse(_ message: NeutronMessage) {
        let dataWidth = 8
        let osc1Start = NeutronMessage.header.count + 3
        let osc2Start = osc1Start + dataWidth
        
        let osc1 = TuningData(packed: Array(message.data[osc1Start..<osc2Start]).sysexToData)
        var osc2 = TuningData(packed: Array(message.data[osc2Start..<message.data.count - 1]).sysexToData)
        
        // Shouldn't have to do this but oscID isn't being sent
        osc2.oscID = 1
        
        print()
        print("MIDI Note: \(osc1.noteNum)")
        print(osc1)
        print(osc2)
        
//        let osc1Data = Data(bytes: osc1Bytes)
//        let osc2Data = Data(bytes: osc2Bytes)
//
//        let osc1Value: UInt32 = osc1Data.withUnsafeBytes { $0.pointee }
//        let osc2Value: UInt32 = osc2Data.withUnsafeBytes { $0.pointee }
//
//        let osc1Period: Float = Float(osc1Value) / 1000000
//        let osc2Period: Float = Float(osc2Value) / 1000000
//
//        print("OSC 1 Period: \(osc1Period)")
//        print("OSC 2 Period: \(osc2Period)")
//
//        let osc1Freq = 1 / osc1Period
//        let osc2Freq = 1 / osc2Period
//
//        print("OSC 1 Freq: \(osc1Freq)")
//        print("OSC 2 Freq: \(osc2Freq)")
//        print()
    }
}
