// LabelComponent.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class EntityLabelNode: SKLabelNode
{
    
}

class LabelComponent: GKComponent
{
    let node: EntityLabelNode
    
    init(entity: GKEntity, fontName: String)
    {
        node = EntityLabelNode(fontNamed: fontName)
        node.entity = entity
        super.init()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
