//
//  DigitAccumulator.swift
//  RPN
//
//  Created by Conner on 9/19/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

public enum DigitAccumulatorError: Error {
    case extraDecimalPoint
    case invalidDigitNumberValue
}

public struct DigitAccumulator {
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int)
    }
    
    public init() {}
    
    public mutating func add(digit: Digit) throws {
        switch digit {
        case .decimalPoint:
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            }
        case .number(let value):
            if value < 0 || 9 < value {
                throw DigitAccumulatorError.invalidDigitNumberValue
            }
        }
        digits.append(digit)
    }
    
    public mutating func clear() {
        digits.removeAll()
    }
    
    public func value() -> Double? {
        let string = digits.map { (digit) -> String in
            switch digit {
            case let .number(x): return String(x)
            case .decimalPoint: return "."
            }
        }.joined()
        
        return Double(string)
    }
    
    private var digits = [Digit]()
}
