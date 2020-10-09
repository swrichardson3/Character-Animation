// TrollAttackAnimationComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollAttackAnimationComponent : GKComponent
{
    let spriteComponent: SpriteComponent
    var attackRightTextures: Array<SKTexture> = []
    var attackLeftTextures: Array<SKTexture> = []
    
    init(entity: GKEntity, attackRightTextures: Array<SKTexture>, attackLeftTextures: Array<SKTexture>)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        self.attackRightTextures = attackRightTextures
        self.attackLeftTextures = attackLeftTextures
        
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
                if(spriteComponent.node.action(forKey: "AttackRight") == nil)
                {
                    let attackRightAnimation = SKAction.animate(with: attackRightTextures, timePerFrame: 0.016)
                    spriteComponent.node.run(attackRightAnimation, withKey: "AttackRight")
                }
                
            case .left:
                if(spriteComponent.node.action(forKey: "AttackLeft") == nil)
                {
                    let attackLeftAnimation = SKAction.animate(with: attackLeftTextures, timePerFrame: 0.016)
                    spriteComponent.node.run(attackLeftAnimation, withKey: "AttackLeft")
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
