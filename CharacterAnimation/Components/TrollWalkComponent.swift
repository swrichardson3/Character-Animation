// Troll1WalkComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollWalkComponent : GKComponent
{
    let spriteComponent: SpriteComponent
    var maxPositionX: CGFloat = 0
    var minPositionX: CGFloat = 0
    var trollWalkSpeed: CGFloat = 0
    var sceneWidth: CGFloat = 0
    var sceneHeight: CGFloat = 0

    init(entity: GKEntity)
    {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        super.init()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyMovement(_ seconds: TimeInterval)
    {
        let spriteNode = spriteComponent.node
        let dist = trollWalkSpeed * CGFloat(seconds)
        
        // Get a reference to the Car Entity.
        if let trollEntity = entity as? TrollEntity
        {
            switch trollEntity.trollDirection
            {
            case .right:
                spriteNode.position.x += dist
                
                if (spriteNode.position.x >= maxPositionX)
                {
                    trollEntity.trollWalkAnimationComponent.stopAnimation("WalkRight")
                    trollEntity.trollDirection = .left
                    trollEntity.trollWalkAnimationComponent.playAnimation()
                }
                
            case .left:
                spriteNode.position.x -= dist
                
                if (spriteNode.position.x <= minPositionX)
                {
                    trollEntity.trollWalkAnimationComponent.stopAnimation("WalkLeft")
                    trollEntity.trollDirection = .right
                    trollEntity.trollWalkAnimationComponent.playAnimation()
                }
            }
        }
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        // Get a reference to the Troll Entity.
        if let trollEntity = entity as? TrollEntity
        {
            if(trollEntity.walkAllowed)
            {
                applyMovement(seconds)
            }
        }
    }
}
