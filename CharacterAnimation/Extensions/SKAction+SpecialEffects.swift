// SKAction+SpecialEffects.swift
// CharacterAnimation
import SpriteKit

public extension SKAction
{
    class func screenShakeWithNode01(amount: CGPoint, duration: TimeInterval) -> SKAction
    {
        let startX:CGFloat = 0.0
        let startY:CGFloat = 0.0
        
        let shakeNumber = Int(duration / 0.016)
        
        var actions = [SKAction]()
        
        for _ in 0...shakeNumber
        {
            let newX = startX + CGFloat(arc4random_uniform(UInt32(amount.x) - UInt32(amount.x / 2)))
            let newY = startY + CGFloat(arc4random_uniform(UInt32(amount.y) - UInt32(amount.y / 2)))
            
            actions.append(SKAction.move(to: CGPoint(x: newX, y: newY), duration: 0.016))
        }
        
        actions.append(SKAction.move(to: CGPoint(x: startX, y: startY), duration: 0.016))
        
        return SKAction.sequence(actions)
    }
    
    // Creates a screen shake animation.
    // @param node: The node to shake. You cannot apply this effect to an SKScene.
    // @param amount: The vector by which the node is displaced.
    // @param oscillations: The number of oscillations; 10 is a good value.
    // @param duration: How long the effect lasts. Shorter is better.
    class func screenShakeWithNode02(node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction
    {
        let oldPosition = node.position
        let newPosition = oldPosition + amount
        
        let effect = SKTMoveEffect(node: node, duration: duration, startPosition: newPosition, endPosition: oldPosition)
        effect.timingFunction = SKTCreateShakeFunction(oscillations: oscillations)
        
        return SKAction.actionWithEffect(effect: effect)
    }
    
    // Creates a screen rotation animation.
    // @param node: You usually want to apply this effect to a pivot node that is centered in the scene. You cannot apply the effect to an SKScene.
    // @param angle: The angle in radians.
    // @param oscillations: The number of oscillations; 10 is a good value.
    // @param duration: How long the effect lasts. Shorter is better.
    class func screenRotateWithNode(node: SKNode, angle: CGFloat, oscillations: Int, duration: TimeInterval) -> SKAction
    {
        let oldAngle = node.zRotation
        let newAngle = oldAngle + angle
        
        let effect = SKTRotateEffect(node: node, duration: duration, startAngle: newAngle, endAngle: oldAngle)
        effect.timingFunction = SKTCreateShakeFunction(oscillations: oscillations)
        
        return SKAction.actionWithEffect(effect: effect)
    }
    
    // Creates a screen zoom animation.
    // @param node: You usually want to apply this effect to a pivot node that is centered in the scene. You cannot apply the effect to an SKScene.
    // @param amount: How much to scale the node in the X and Y directions.
    // @param oscillations: The number of oscillations. Note that 10 is a good value.
    // @param duration: How long the effect lasts. Shorter is better.
    class func screenZoomWithNode(node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction
    {
        let oldScale = CGPoint(x: node.xScale, y: node.yScale)
        let newScale = oldScale * amount
        
        let effect = SKTScaleEffect(node: node, duration: duration, startScale: newScale, endScale: oldScale)
        effect.timingFunction = SKTCreateShakeFunction(oscillations: oscillations)
        
        return SKAction.actionWithEffect(effect: effect)
    }
    
    // Causes the scene background to flash for duration seconds.
    class func colorGlitchWithScene(scene: SKScene, originalColor: SKColor, duration: TimeInterval) -> SKAction
    {
        return SKAction.customAction(withDuration: duration) {(node, elapsedTime) in
            if elapsedTime < CGFloat(duration)
            {
                scene.backgroundColor = SKColorWithRGB(r: Int(arc4random_uniform(256)), g: Int(arc4random_uniform(256)), b: Int(arc4random_uniform(256)))
            }
                
            else
            {
                scene.backgroundColor = originalColor
            }
        }
    }
}
