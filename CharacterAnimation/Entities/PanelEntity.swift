// PanelEntity.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class PanelEntity: GKEntity
{
    var spriteComponent: SpriteComponent!
    
    init(imageName: String)
    {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        
        setupPhysics()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhysics()
    {
    
    }
}
