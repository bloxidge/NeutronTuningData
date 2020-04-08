//
//  Options.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 06/08/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

enum OptionType: String {
    case tuning = "t"
    case settings = "s"
    case help = "h"
    
    init?(_ value: String) {
        var value = value
        value.removeFirst()
        
        // Double '--' option
        if value.first! == "-" {
            value.removeFirst()
            value = String(value.first!)
        }
        
        guard let option = OptionType(rawValue: value) else {
            print("Illegal option", type: .error)
            print("")
            usage()
            exit(-1)
        }
        self = option
    }
}
