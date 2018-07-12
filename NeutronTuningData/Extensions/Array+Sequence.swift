//
//  Array+Sequence.swift
//  NeutronTuningData
//
//  Created by Peter Bloxidge on 09/07/2018.
//  Copyright © 2018 Peter Bloxidge. All rights reserved.
//

import Foundation

extension Array {
    func split(every chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

extension Array where Element: Equatable {
    func removing(suffix: Element) -> [Element] {
        var array = self
        var previousValue = suffix
        
        for i in (0..<array.endIndex).reversed() {
            let value = array[i]
            guard value == previousValue else { break }
            array.remove(at: i)
            previousValue = value
        }
        return array
    }
}

extension Sequence {
    func allSatisfy(_ predicate: (Element) -> Bool) -> Bool {
        return first(where: { !predicate($0) }) == nil
    }
}
