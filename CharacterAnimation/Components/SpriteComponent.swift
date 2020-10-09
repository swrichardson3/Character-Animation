// SpriteComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class EntitySpriteNode: SKSpriteNode
{
    
}

class SpriteComponent: GKComponent
{
    let node: EntitySpriteNode
    
    init(entity: GKEntity, texture: SKTexture, size: CGSize)
    {
        node = EntitySpriteNode(texture: texture, color: .white, size: size)
        node.entity = entity
        super.init()
    }
    
    init(entity: GKEntity, color: SKColor, size: CGSize)
    {
        node = EntitySpriteNode(color: color, size: size)
        node.entity = entity
        super.init()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
