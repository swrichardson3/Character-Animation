// LandEntity.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class LandEntity: GKEntity
{
    unowned let scene: GamePlayingScene
    
    var spriteComponent: SpriteComponent!

    init(scene: SKScene, imageName: String)
    {
        self.scene = scene as! GamePlayingScene
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        
        self.scene.addEntity(entity: self)
        
        setupPhysics()
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhysics()
    {
        let spriteNode = spriteComponent.node
        spriteNode.physicsBody?.isDynamic = false
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.allowsRotation = false
        spriteNode.physicsBody = SKPhysicsBody(rectangleOf: spriteNode.size)
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategory.Land
        spriteNode.physicsBody?.collisionBitMask = 0
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
}
