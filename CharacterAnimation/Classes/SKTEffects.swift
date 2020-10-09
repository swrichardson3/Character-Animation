// SKTEffects.swift
// CharacterAnimation
import SpriteKit

// Allows you to perform actions with custom timing
// functions. Note that SKAction does not have a good
// concept of a timing function, so we need to replicate
// the actions using SKTEffect subclasses.
public class SKTEffect
{
    unowned var node: SKNode
    var duration: TimeInterval
    public var timingFunction: ((CGFloat) -> CGFloat)?
    
    public init(node: SKNode, duration: TimeInterval)
    {
        self.node = node
        self.duration = duration
        timingFunction = SKTTimingFunctionLinear
    }
    
    public func update(t: CGFloat)
    {
        // The subclasses will implement this.
    }
}

// Moves a node from its current position to a new position.
public class SKTMoveEffect: SKTEffect
{
    var startPosition: CGPoint
    var delta: CGPoint
    var previousPosition: CGPoint
    
    public init(node: SKNode, duration: TimeInterval, startPosition: CGPoint, endPosition: CGPoint)
    {
        previousPosition = node.position
        self.startPosition = startPosition
        delta = endPosition - startPosition
        super.init(node: node, duration: duration)
    }
    
    public override func update(t: CGFloat)
    {
        // This allows multiple SKTMoveEffect objects to
        // modify the same node at the same time.
        let newPosition = startPosition + delta * t
        let difference  = newPosition - previousPosition
        previousPosition = newPosition
        node.position = node.position + difference
    }
}

// Scales a node to a certain scale factor.
public class SKTScaleEffect: SKTEffect
{
    var startScale: CGPoint
    var delta: CGPoint
    var previousScale: CGPoint
    
    public init(node: SKNode, duration: TimeInterval, startScale: CGPoint, endScale: CGPoint)
    {
        previousScale = CGPoint(x: node.xScale, y: node.yScale)
        self.startScale = startScale
        delta = endScale - startScale
        super.init(node: node, duration: duration)
    }
    
    public override func update(t: CGFloat)
    {
        let newScale = startScale + delta * t
        let difference = newScale / previousScale
        previousScale = newScale
        node.xScale *= difference.x
        node.yScale *= difference.y
    }
}

// Rotates a node to a certain angle.
public class SKTRotateEffect: SKTEffect
{
    var startAngle: CGFloat
    var delta: CGFloat
    var previousAngle: CGFloat
    
    public init(node: SKNode, duration: TimeInterval, startAngle: CGFloat, endAngle: CGFloat)
    {
        previousAngle = node.zRotation
        self.startAngle = startAngle
        delta = endAngle - startAngle
        super.init(node: node, duration: duration)
    }
    
    public override func update(t: CGFloat)
    {
        let newAngle = startAngle + delta*t
        let diff = newAngle - previousAngle
        previousAngle = newAngle
        node.zRotation += diff
    }
}

// This Wrapper will allow you to use SKTEffect
// objects as regular SKActions.
public extension SKAction
{
    class func actionWithEffect(effect: SKTEffect) -> SKAction
    {
        return SKAction.customAction(withDuration: effect.duration) { node, elapsedTime in
            var t = elapsedTime / CGFloat(effect.duration)
            
            if let timingFunction = effect.timingFunction {
                t = timingFunction(t)
            }
            
            effect.update(t: t)
        }
    }
}
