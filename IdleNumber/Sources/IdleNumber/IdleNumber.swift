import Foundation

public struct IdleNumber: Equatable {

    public init(_ value: Double, _ magnitude: Int) {
        self.value = value
        self.magnitude = magnitude
    }

    internal var value: Double
    internal var magnitude: Int
}
