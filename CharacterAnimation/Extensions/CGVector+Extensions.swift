// CGVector+Extensions.swift
// CharacterAnimation
import CoreGraphics
import SpriteKit

public extension CGVector
{
    
    // Creates a new CGVector given a CGPoint.
    init(point: CGPoint)
    {
        self.init(dx: point.x, dy: point.y)
    }
    
    // Given an angle in radians, creates a vector of length 1.0
    // and returns the result as a new CGVector. An angle of 0 is
    // assumed to point to the right.
    init(angle: CGFloat) {
        self.init(dx: cos(angle), dy: sin(angle))
    }
    
    mutating func offset(dx: CGFloat, dy: CGFloat) -> CGVector
    {
        self.dx += dx
        self.dy += dy
        return self
    }
    
    func length() -> CGFloat
    {
        return sqrt(dx*dx + dy*dy)
    }
    
    func lengthSquared() -> CGFloat
    {
        return dx*dx + dy*dy
    }
    
    func normalized() -> CGVector
    {
        let len = length()
        return len>0 ? self / len : CGVector.zero
    }
    
    mutating func normalize() -> CGVector
    {
        self = normalized()
        return self
    }
    
    func distance(vector: CGVector) -> CGFloat
    {
        return (self - vector).length()
    }
    
    // Returns the angle in radians of the vector described by
    // the CGVector. The range of the angle is -π to π. An angle
    // of 0 points to the right.
    var angle: CGFloat
    {
        return atan2(dy, dx)
    }
}

public func + (left: CGVector, right: CGVector) -> CGVector
{
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

public func += ( left: inout CGVector, right: CGVector)
{
    left = left + right
}

public func - (left: CGVector, right: CGVector) -> CGVector
{
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

public func -= ( left: inout CGVector, right: CGVector)
{
    left = left - right
}

public func * (left: CGVector, right: CGVector) -> CGVector
{
    return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

public func *= ( left: inout CGVector, right: CGVector)
{
    left = left * right
}

public func * (vector: CGVector, scalar: CGFloat) -> CGVector
{
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}

public func *= ( vector: inout CGVector, scalar: CGFloat)
{
    vector = vector * scalar
}

public func / (left: CGVector, right: CGVector) -> CGVector
{
    return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}

public func /= ( left: inout CGVector, right: CGVector)
{
    left = left / right
}

public func / (vector: CGVector, scalar: CGFloat) -> CGVector
{
    return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}

public func /= ( vector: inout CGVector, scalar: CGFloat)
{
    vector = vector / scalar
}

// Performs a Linear Interpolation between two CGVector values.
public func lerp(start: CGVector, end: CGVector, t: CGFloat) -> CGVector
{
    return CGVector(dx: start.dx + (end.dx - start.dx)*t, dy: start.dy + (end.dy - start.dy)*t)
}
