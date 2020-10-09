// CGPoint+Extensions.swift
// CharacterAnimation
import CoreGraphics
import SpriteKit

public extension CGPoint
{
    // Creates a new CGPoint given a CGVector.
    init(vector: CGVector)
    {
        self.init(x: vector.dx, y: vector.dy)
    }
    
    // Given an angle in radians, creates a vector of length 1.0
    // and returns the result as a new CGPoint. An angle of 0 is
    // assumed to point to the right.
    init(angle: CGFloat)
    {
        self.init(x: cos(angle), y: sin(angle))
    }
    
    mutating func offset(dx: CGFloat, dy: CGFloat) -> CGPoint
    {
        x += dx
        y += dy
        return self
    }
    
    func length() -> CGFloat
    {
        return sqrt(x*x + y*y)
    }
    
    func lengthSquared() -> CGFloat
    {
        return x*x + y*y
    }
    
    func normalized() -> CGPoint
    {
        let result = length()
        return result > 0 ? self / result : CGPoint.zero
    }
    
    mutating func normalize() -> CGPoint
    {
        self = normalized()
        return self
    }
    
    func distance(point: CGPoint) -> CGFloat
    {
        return (self - point).length()
    }
    
    // Returns the angle in radians of the vector described by
    // the CGPoint. The range of the angle is -π to π. An angle
    // of 0 points to the right.
    var angle: CGFloat
    {
        return atan2(y, x)
    }
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += ( left: inout CGPoint, right: CGPoint)
{
    left = left + right
}

public func + (left: CGPoint, right: CGVector) -> CGPoint
{
    return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}

public func += ( left: inout CGPoint, right: CGVector)
{
    left = left + right
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func -= ( left: inout CGPoint, right: CGPoint)
{
    left = left - right
}

public func - (left: CGPoint, right: CGVector) -> CGPoint
{
    return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}

public func -= ( left: inout CGPoint, right: CGVector)
{
    left = left - right
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public func *= ( left: inout CGPoint, right: CGPoint)
{
    left = left * right
}

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func *= ( point: inout CGPoint, scalar: CGFloat)
{
    point = point * scalar
}

public func * (left: CGPoint, right: CGVector) -> CGPoint
{
    return CGPoint(x: left.x * right.dx, y: left.y * right.dy)
}

public func *= ( left: inout CGPoint, right: CGVector)
{
    left = left * right
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public func /= ( left: inout CGPoint, right: CGPoint)
{
    left = left / right
}

public func / (point: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

public func /= ( point: inout CGPoint, scalar: CGFloat)
{
    point = point / scalar
}

public func / (left: CGPoint, right: CGVector) -> CGPoint
{
    return CGPoint(x: left.x / right.dx, y: left.y / right.dy)
}

public func /= ( left: inout CGPoint, right: CGVector)
{
    left = left / right
}

// Performs a Linear Interpolation between two CGPoint values.
public func lerp(start: CGPoint, end: CGPoint, t: CGFloat) -> CGPoint
{
    return CGPoint(x: start.x + (end.x - start.x)*t, y: start.y + (end.y - start.y)*t)
}
