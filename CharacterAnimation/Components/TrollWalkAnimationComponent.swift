// TrollWalkAnimationComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollWalkAnimationComponent: GKComponent
{
    let spriteComponent: SpriteComponent
    var walkRightTextures: Array<SKTexture> = []
    var walkLeftTextures: Array<SKTexture> = []
    
    init(entity: GKEntity, walkRightTextures: Array<SKTexture>, walkLeftTextures: Array<SKTexture>)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        self.walkRightTextures = walkRightTextures
        self.walkLeftTextures = walkLeftTextures
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    func playAnimation()
    {
        if let troll = entity as? TrollEntity
        {
            switch troll.trollDirection
            {
            case .right:
                if(spriteComponent.node.action(forKey: "WalkRight") == nil)
                {
                    let walkRightAnimation = SKAction.animate(with: walkRightTextures, timePerFrame: 0.016)
                    let repeatAction = SKAction.repeatForever(walkRightAnimation)
                    spriteComponent.node.run(repeatAction, withKey: "WalkRight")
                }
                
            case .left:
                if(spriteComponent.node.action(forKey: "WalkLeft") == nil)
                {
                    let walkLeftAnimation = SKAction.animate(with: walkLeftTextures, timePerFrame: 0.016)
                    let repeatAction = SKAction.repeatForever(walkLeftAnimation)
                    spriteComponent.node.run(repeatAction, withKey: "WalkLeft")
                }
            }
        }
    }
    
    func stopAnimation(_ name:String)
    {
        spriteComponent.node.removeAction(forKey: name)
    }
}
