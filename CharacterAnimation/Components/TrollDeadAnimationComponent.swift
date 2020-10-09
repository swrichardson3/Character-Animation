// TrollDeadAnimationComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollDeadAnimationComponent : GKComponent
{
    let spriteComponent: SpriteComponent
    var deadRightTextures: Array<SKTexture> = []
    var deadLeftTextures: Array<SKTexture> = []
    
    init(entity: GKEntity, deadRightTextures: Array<SKTexture>, deadLeftTextures: Array<SKTexture>)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        self.deadRightTextures = deadRightTextures
        self.deadLeftTextures = deadLeftTextures
        
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
                if(spriteComponent.node.action(forKey: "DeadRight") == nil)
                {
                    /*let deadRightAnimation = SKAction.animate(with: self.deadRightTextures, timePerFrame: 0.016)
                    
                    let completionAction = SKAction.run {
                        troll.scene.nextScene(GameOverState.self)
                    }
                    
                    let sequenceAction = SKAction.sequence([deadRightAnimation, completionAction])
                    spriteComponent.node.run(sequenceAction, withKey: "DeadRight")*/
                    
                    // Use Node+Extensions
                    let deadRightAnimation = SKAction.animate(with: self.deadRightTextures, timePerFrame: 0.016)
                    let completion = {troll.scene.nextScene(GameOverState.self)}
                    spriteComponent.node.run(action: deadRightAnimation, withKey: "DeadRight", optionalCompletion: completion)
                }
                
            case .left:
                if(spriteComponent.node.action(forKey: "DeadLeft") == nil)
                {
                    /*let deadLeftAnimation = SKAction.animate(with: deadLeftTextures, timePerFrame: 0.016)
                    
                    let completionAction = SKAction.run {
                        troll.scene.nextScene(GameOverState.self)
                    }
                    
                    let sequenceAction = SKAction.sequence([deadLeftAnimation, completionAction])
                    spriteComponent.node.run(sequenceAction, withKey: "DeadLeft")*/
                    
                    // Use Node+Extensions
                    let deadLeftAnimation = SKAction.animate(with: deadLeftTextures, timePerFrame: 0.016)
                    let completion = {troll.scene.nextScene(GameOverState.self)}
                    spriteComponent.node.run(action: deadLeftAnimation, withKey: "DeadLeft", optionalCompletion: completion)
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
