// TrollHurtAnimationComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollHurtAnimationComponent : GKComponent
{
    let spriteComponent: SpriteComponent
    var hurtRightTextures: Array<SKTexture> = []
    var hurtLeftTextures: Array<SKTexture> = []
    
    init(entity: GKEntity, hurtRightTextures: Array<SKTexture>, hurtLeftTextures: Array<SKTexture>)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        self.hurtRightTextures = hurtRightTextures
        self.hurtLeftTextures = hurtLeftTextures
        
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
                if(spriteComponent.node.action(forKey: "HurtRight") == nil)
                {
                    let hurtRightAnimation = SKAction.animate(with: hurtRightTextures, timePerFrame: 0.016)
                    spriteComponent.node.run(hurtRightAnimation, withKey: "HurtRight")
                }
                
            case .left:
                if(spriteComponent.node.action(forKey: "HurtLeft") == nil)
                {
                    let hurtLeftAnimation = SKAction.animate(with: hurtLeftTextures, timePerFrame: 0.016)
                    spriteComponent.node.run(hurtLeftAnimation, withKey: "HurtLeft")
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
