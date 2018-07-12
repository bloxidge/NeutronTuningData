//
//  MIDIEngine.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 06/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation
import CoreMIDI

class MIDIEngine {
    
    static let instance = MIDIEngine()
    
    private var timeZero = Date()
    private var midiClient: MIDIClientRef = 0
    private var outPort: MIDIPortRef = 0
    private var inPort: MIDIPortRef = 0
    
    private var sources: [MIDIEndpointRef] = []
    private var destinations: [MIDIEndpointRef] = []
    
    var delegate: MessageHandlerDelegate?
    
    init() {
        MIDIClientCreate("MidiTestClient" as CFString, nil, nil, &midiClient)
        MIDIOutputPortCreate(midiClient, "MidiTestOutPort" as CFString, &outPort)
        MIDIInputPortCreate(midiClient, "MidiTestInPort" as CFString, readIncomingMIDI, nil, &inPort)
        
        getSourcesAndDestinations()
        printSourcesAndDestinations()
        
        connectSources()
    }
    
    func getSourcesAndDestinations() {
        for i in 0..<MIDIGetNumberOfDestinations() {
            let endpoint = MIDIGetDestination(i)
            if endpoint != 0 {
                destinations.append(endpoint)
            }
        }
        for i in 0..<MIDIGetNumberOfSources() {
            let endpoint = MIDIGetSource(i)
            if endpoint != 0 {
                sources.append(endpoint)
            }
        }
    }
    
    func printSourcesAndDestinations() {
        print("MIDI Destinations: \(destinations.count)")
        for destination in destinations {
            print("\t- \(destination.displayName)")
        }
        print("");
        
        print("MIDI Sources: \(sources.count)")
        for source in sources {
            print("\t- \(source.displayName)")
        }
        print("");
    }
    
    func connectSources() {
        for (i, _) in sources.enumerated() {
            MIDIPortConnectSource(inPort, sources[i], &sources[i])
        }
    }
    
    func sendMessage(_ message: [UInt8]) {
        var packet = MIDIPacket()
        packet.timeStamp = UInt64(Date().timeIntervalSince(timeZero))
        packet.length = UInt16(message.count)
        
        // There isn't a better way of doing this
        for (i, byte) in message.enumerated() {
            switch i {
            case 0: packet.data.0 = byte
            case 1: packet.data.1 = byte
            case 2: packet.data.2 = byte
            case 3: packet.data.3 = byte
            case 4: packet.data.4 = byte
            case 5: packet.data.5 = byte
            case 6: packet.data.6 = byte
            case 7: packet.data.7 = byte
            case 8: packet.data.8 = byte
            case 9: packet.data.9 = byte
            case 10: packet.data.10 = byte
            case 11: packet.data.11 = byte
            case 12: packet.data.12 = byte
            case 13: packet.data.13 = byte
            case 14: packet.data.14 = byte
            case 15: packet.data.15 = byte
            case 16: packet.data.16 = byte
            case 17: packet.data.17 = byte
            case 18: packet.data.18 = byte
            case 19: packet.data.19 = byte
            case 20: packet.data.20 = byte
            case 21: packet.data.21 = byte
            case 22: packet.data.22 = byte
            case 23: packet.data.23 = byte
            case 24: packet.data.24 = byte
            case 25: packet.data.25 = byte
            case 26: packet.data.26 = byte
            case 27: packet.data.27 = byte
            case 28: packet.data.28 = byte
            case 29: packet.data.29 = byte
            case 30: packet.data.30 = byte
            case 31: packet.data.31 = byte
            default:
                fatalError("SysEx message this long is not supported yet... Why are you sending such a long SysEx message anyway?!")
            }
        }
        
        var packetList = MIDIPacketList(numPackets: 1, packet: packet)
        for dest in destinations {
            MIDISend(outPort, dest, &packetList)
        }
    }
}

// This function needs to be global to satisfy callback to a C function pointer

/**
 * Entry point for incoming MIDI messages.
 * Messages are sometimes incomplete so need to be handled in subsequent function.
 */
func readIncomingMIDI(pktList: UnsafePointer<MIDIPacketList>, readProcRefCon: UnsafeMutableRawPointer?, srcConnRefCon: UnsafeMutableRawPointer?) {
    let packetList: MIDIPacketList = pktList.pointee
    let srcRef: MIDIEndpointRef = srcConnRefCon!.load(as: MIDIEndpointRef.self)
    
    var output: [UInt8] = []
    var packet = packetList.packet
    
    for _ in 1...packetList.numPackets {
        output.removeAll()
        
        // bytes mirror contains all the zero values in the ridiulous packet data tuple
        // so use the packet length to iterate.
        let bytes = Mirror(reflecting: packet.data).children
        
        var i = packet.length
        for attr in bytes {
            output.append(attr.value as! UInt8)
            i -= 1
            if (i <= 0) {
                break
            }
        }
        
        // Here is where the magic happens...
        MIDIEngine.instance.delegate?.messageHandler(didReceiveBytes: output, fromSource: srcRef)
        
        packet = MIDIPacketNext(&packet).pointee
    }
}
