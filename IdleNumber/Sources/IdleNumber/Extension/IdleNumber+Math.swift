//
//  IdleNumber+Math.swift
//  
//
//  Created by Alex Chekushkin on 22/07/2023.
//

import Foundation

public extension IdleNumber {
    
    // MARK: - Addition
    static func +(lhs: IdleNumber, rhs: IdleNumber) -> IdleNumber {
        if lhs.magnitude == rhs.magnitude {
            let resultValue = lhs.value * pow(10, Double(lhs.magnitude - rhs.magnitude)) + rhs.value
            let result = IdleNumber(resultValue, lhs.magnitude)

            return applyFormatting(to: result)
        } else if lhs.magnitude > rhs.magnitude + 1 || lhs.magnitude + 1 < rhs.magnitude {
            return lhs.magnitude > rhs.magnitude ? lhs : rhs
        } else {
            let biggerNumber = lhs.magnitude > rhs.magnitude ? lhs : rhs
            var smallerNumber = lhs.magnitude > rhs.magnitude ? rhs : lhs
            smallerNumber.magnitude += 1
            smallerNumber.value = smallerNumber.value / 1000

            return biggerNumber + smallerNumber
        }
    }

    // MARK: - Subtraction
    static func -(lhs: IdleNumber, rhs: IdleNumber) -> IdleNumber {
        if lhs.magnitude == rhs.magnitude {
            let resultValue = lhs.value * pow(10, Double(lhs.magnitude - rhs.magnitude)) - rhs.value
            if resultValue == 0 {
                return IdleNumber(0.0, 0)
            } else if resultValue < 1{
                return IdleNumber(resultValue, lhs.magnitude)
            }
            return IdleNumber(resultValue, lhs.magnitude)
        }
        else if lhs.magnitude > rhs.magnitude + 1 || lhs.magnitude + 1 < rhs.magnitude {
            return lhs.magnitude > rhs.magnitude ? lhs : rhs
        } else {
            let isNegative = lhs.magnitude < rhs.magnitude
            var result: IdleNumber

            if isNegative {
                let bigger = IdleNumber(rhs.value * 1000, rhs.magnitude - 1)
                let smaller = lhs
                result = smaller - bigger
                result = applyFormatting(to: result)
            } else {
                result = (rhs - lhs)
                result = IdleNumber(result.value * -1, result.magnitude)
            }
            return result
        }
    }

    // MARK: - Multiplication
    static func *(lhs: IdleNumber, rhs: IdleNumber) -> IdleNumber {
        let resultValue = lhs.value * rhs.value
        let resultMagnitude = lhs.magnitude + rhs.magnitude
        let result = IdleNumber(resultValue, resultMagnitude)

        if resultValue == 0 {
            return IdleNumber(0, 0)
        }
        
        return applyFormatting(to: result)
    }

    static func *(lhs: IdleNumber, rhs: Double) -> IdleNumber {
        let resultValue = lhs.value * rhs
        let result = IdleNumber(resultValue, lhs.magnitude)

        if resultValue == 0 {
            return IdleNumber(0, 0)
        }

        return applyFormatting(to: result)
    }

    // MARK: - Division
    static func /(lhs: IdleNumber, rhs: IdleNumber) -> IdleNumber {
        let resultValue = lhs.value / rhs.value
        let resultMagnitude = lhs.magnitude - rhs.magnitude
        let result = IdleNumber(resultValue, resultMagnitude)
        
        return applyFormatting(to: result)
    }

    static func /(lhs: IdleNumber, rhs: Double) -> IdleNumber {
        let resultValue = lhs.value / rhs
        let result = IdleNumber(resultValue, lhs.magnitude)
        
        return applyFormatting(to: result)
    }
}

private extension IdleNumber {
    private static func applyFormatting(to idleNumber: IdleNumber) -> IdleNumber {
        var formattingNumber = idleNumber
        let positiveCheck = formattingNumber.value >= 1000
        let negativeCheck = formattingNumber.value <= -1000
        let shouldDecreaseMagnitude = (0..<1).contains(formattingNumber.value)

        if positiveCheck || negativeCheck {
            formattingNumber.value = formattingNumber.value / 1000
            formattingNumber.magnitude = formattingNumber.magnitude + 1
        }

        if positiveCheck || negativeCheck {
            formattingNumber = applyFormatting(to: formattingNumber)
        }

        if shouldDecreaseMagnitude {
            formattingNumber.value *= 1000
            formattingNumber.magnitude -= 1
        }

        if formattingNumber.magnitude < 0 {
            return IdleNumber(0, 0)
        }

        return formattingNumber
    }
}
