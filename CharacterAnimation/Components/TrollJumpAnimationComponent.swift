// TrollJumpAnimationComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollJumpAnimationComponent : GKComponent
{
    let spriteComponent: SpriteComponent
    var jumpRightTextures: Array<SKTexture> = []
    var jumpLeftTextures: Array<SKTexture> = []
    
    init(entity: GKEntity, jumpRightTextures: Array<SKTexture>, jumpLeftTextures: Array<SKTexture>)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        self.jumpRightTextures = jumpRightTextures
        self.jumpLeftTextures = jumpLeftTextures
        
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
                if(spriteComponent.node.action(forKey: "JumpRight") == nil)
                {
                    let jumpRightAnimation = SKAction.animate(with: jumpRightTextures, timePerFrame: 0.016)
                    spriteComponent.node.run(jumpRightAnimation, withKey: "JumpRight")
                }
                
            case .left:
                if(spriteComponent.node.action(forKey: "JumpLeft") == nil)
                {
                    let jumpLeftAnimation = SKAction.animate(with: jumpLeftTextures, timePerFrame: 0.016)
                    spriteComponent.node.run(jumpLeftAnimation, withKey: "JumpLeft")
                }
            }
        }
    }
    
    func stopAnimation(_ name:String)
    {
        spriteComponent.node.removeAction(forKey: name)
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        
    }
}

