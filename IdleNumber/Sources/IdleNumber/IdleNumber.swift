import Foundation

public struct IdleNumber: Equatable {
    public var value: Double
    public var magnitude: Int

    public init(_ value: Double, _ magnitude: Int) {
        self.value = value
        self.magnitude = magnitude
    }
}

