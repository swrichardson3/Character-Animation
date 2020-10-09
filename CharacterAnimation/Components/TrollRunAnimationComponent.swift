// TrollRunAnimationComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollRunAnimationComponent: GKComponent
{
    let spriteComponent: SpriteComponent
    var runRightTextures: Array<SKTexture> = []
    var runLeftTextures: Array<SKTexture> = []
    
    init(entity: GKEntity, runRightTextures: Array<SKTexture>, runLeftTextures: Array<SKTexture>)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        self.runRightTextures = runRightTextures
        self.runLeftTextures = runLeftTextures
        
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
                if(spriteComponent.node.action(forKey: "RunRight") == nil)
                {
                    let runRightAnimation = SKAction.animate(with: runRightTextures, timePerFrame: 0.016)
                    let repeatAction = SKAction.repeatForever(runRightAnimation)
                    spriteComponent.node.run(repeatAction, withKey: "RunRight")
                }
                
            case .left:
                if(spriteComponent.node.action(forKey: "RunLeft") == nil)
                {
                    let runLeftAnimation = SKAction.animate(with: runLeftTextures, timePerFrame: 0.016)
                    let repeatAction = SKAction.repeatForever(runLeftAnimation)
                    spriteComponent.node.run(repeatAction, withKey: "RunLeft")
                }
            }
        }
    }
    
    func stopAnimation(_ name:String)
    {
        spriteComponent.node.removeAction(forKey: name)
    }
}
