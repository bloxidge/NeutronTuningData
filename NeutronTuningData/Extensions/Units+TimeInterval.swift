//
//  Units+TimeInterval.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 09/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    internal static var secondsPerDay: Double { return 24 * secondsPerHour }
    internal static var secondsPerHour: Double { return 60 * secondsPerMinute }
    internal static var secondsPerMinute: Double { return 60 }
    internal static var millisecondsPerSecond: Double { return 1000 }
    internal static var microsecondsPerSecond: Double { return 1000 * millisecondsPerSecond }
    internal static var nanosecondsPerSecond: Double { return 1000 * microsecondsPerSecond }
    
    /// - Returns: The `TimeInterval` in days.
    public var days: Double {
        return self / TimeInterval.secondsPerDay
    }
    
    /// - Returns: The `TimeInterval` in hours.
    public var hours: Double {
        return self / TimeInterval.secondsPerHour
    }
    
    /// - Returns: The `TimeInterval` in minutes.
    public var minutes: Double {
        return self / TimeInterval.secondsPerMinute
    }
    
    /// - Returns: The `TimeInterval` in seconds.
    public var seconds: Double {
        return self
    }
    
    /// - Returns: The `TimeInterval` in milliseconds.
    public var milliseconds: Double {
        return self * TimeInterval.millisecondsPerSecond
    }
    
    /// - Returns: The `TimeInterval` in microseconds.
    public var microseconds: Double {
        return self * TimeInterval.microsecondsPerSecond
    }
    
    /// - Returns: The `TimeInterval` in nanoseconds.
    public var nanoseconds: Double {
        return self * TimeInterval.nanosecondsPerSecond
    }
}
