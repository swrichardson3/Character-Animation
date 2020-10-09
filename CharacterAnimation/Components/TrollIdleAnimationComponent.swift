// TrollIdleAnimationComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollIdleAnimationComponent : GKComponent
{
    let spriteComponent: SpriteComponent
    var idleRightTextures: Array<SKTexture> = []
    var idleLeftTextures: Array<SKTexture> = []
    
    init(entity: GKEntity, idleRightTextures: Array<SKTexture>, idleLeftTextures: Array<SKTexture>)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        self.idleRightTextures = idleRightTextures
        self.idleLeftTextures = idleLeftTextures
        
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
                if(spriteComponent.node.action(forKey: "IdleRight") == nil)
                {
                    let idleRightAnimation = SKAction.animate(with: idleRightTextures, timePerFrame: 0.016)
                    let repeatAction = SKAction.repeatForever(idleRightAnimation)
                    spriteComponent.node.run(repeatAction, withKey: "IdleRight")
                }
                
            case .left:
                if(spriteComponent.node.action(forKey: "IdleLeft") == nil)
                {
                    let idleLeftAnimation = SKAction.animate(with: idleLeftTextures, timePerFrame: 0.016)
                    let repeatAction = SKAction.repeatForever(idleLeftAnimation)
                    spriteComponent.node.run(repeatAction, withKey: "IdleLeft")
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
