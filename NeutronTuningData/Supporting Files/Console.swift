//
//  Console.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 06/08/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//
import Foundation

enum OutputType {
    case error
    case standard
}

func print(_ message: Any, type: OutputType = .standard) {
    switch type {
    case .error:
        fputs("Error: \(message)\n", stderr)
    case .standard:
        Swift.print(message)
    }
}

func usage() {
    let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
    
    print("Usage:")
    print("  \(executableName) [options]")
    print("")
    print("Options:")
    print("  [no options]    No messages printed, just sends a keep-alive message (for debugging)")
    print("  -t --tuning     Print tuning data responses")
    print("  -s --settings   Print global settings data responses")
    print("  -h --help       Show this screen.")
    print("")
}
