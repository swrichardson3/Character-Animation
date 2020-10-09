// Int+Extensions.swift
// CharacterAnimation
import CoreGraphics

public extension Int
{
    // Ensures that the integer value stays with the specified range.
    func clamped(range: Range<Int>) -> Int
    {
        return (self < range.lowerBound) ? range.lowerBound : ((self >= range.upperBound) ? range.upperBound - 1: self)
    }
    
    // Ensures that the integer value stays with the specified range.
    mutating func clamp(range: Range<Int>) -> Int
    {
        self = clamped(range: range)
        return self
    }
    
    
    // Ensures that the integer value stays between the given values, inclusive.
    func clamped(v1: Int, v2: Int) -> Int
    {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    
    
    // Ensures that the integer value stays between the given values, inclusive.
    mutating func clamp(v1: Int, v2: Int) -> Int
    {
        self = clamped(v1: v1, v2: v2)
        return self
    }
    
    
    // Returns a random integer in the specified range.
    static func random(range: Range<Int>) -> Int
    {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
    }
    
    
    // Returns a random integer between 0 and n-1.
    static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    // Returns a random integer in the range min...max, inclusive.
    static func random(min: Int, max: Int) -> Int
    {
        assert(min < max)
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
