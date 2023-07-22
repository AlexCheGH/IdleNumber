//
//  IdleNumber+Formated.swift
//  
//
//  Created by Alex Chekushkin on 22/07/2023.
//

import Foundation

public extension IdleNumber {
    var formatted: String {
        return toString()
    }
}

private extension IdleNumber {
    private func toString() -> String {
        let formattedValue = String(format: "%.2f", value)
        let unit = getUnit()
        return "\(formattedValue)\(unit)"
    }

    private func getUnit() -> String {
        var unit = ""
        let magnitudeMultiplier = 10 // Maximum magnitude that can be represented: 33800
       
        let maxIndex = (indexToMagnitude.count * 26 * 26) * magnitudeMultiplier
        if magnitude < indexToMagnitude.count {
            unit = indexToMagnitude[magnitude]
        } else if magnitude <= maxIndex {
            let unitInt = magnitude - indexToMagnitude.count
            let thirdUnit = unitInt % 26
            let secondUnit = (unitInt / 26) % 26
            let firstUnit = unitInt / (26 * 26)
            if firstUnit == 0 && secondUnit == 25 {
                unit = String(UnicodeScalar(UInt8(97 + thirdUnit)))
            } else {
                if firstUnit == 0 {
                    unit = String(UnicodeScalar(UInt8(97 + secondUnit))) +
                    String(UnicodeScalar(UInt8(97 + thirdUnit)))
                } else {
                    unit = String(UnicodeScalar(UInt8(65 + firstUnit - 1))) +
                    String(UnicodeScalar(UInt8(97 + secondUnit))) +
                    String(UnicodeScalar(UInt8(97 + thirdUnit)))
                }
            }
        }
        return unit
    }

    private var indexToMagnitude: [String] { ["", "K", "M", "B", "T"] }
}
