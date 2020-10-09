// TrollEntity.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class TrollEntity: GKEntity
{
    unowned let scene: GamePlayingScene
    
    var spriteComponent: SpriteComponent!
    var trollWalkComponent: TrollWalkComponent!
    var trollRunComponent: TrollRunComponent!
    var trollIdleAnimationComponent: TrollIdleAnimationComponent!
    var trollWalkAnimationComponent: TrollWalkAnimationComponent!
    var trollRunAnimationComponent: TrollRunAnimationComponent!
    var trollAttackAnimationComponent: TrollAttackAnimationComponent!
    var trollJumpAnimationComponent: TrollJumpAnimationComponent!
    var trollHurtAnimationComponent: TrollHurtAnimationComponent!
    var trollDeadAnimationComponent: TrollDeadAnimationComponent!
    
    var trollState: TrollState = .idle
    var trollDirection: TrollDirection = .right
    var walkAllowed = false
    var runAllowed = false
    var trollName: String
    
    init(scene: SKScene, imageName: String, trollName: String)
    {
        self.scene = scene as! GamePlayingScene
        self.trollName = trollName
        
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        
        self.scene.addEntity(entity: self)
        
        setupWalkComponent()
        setupRunComponent()
        setupIdleAnimationComponent()
        setupWalkAnimationComponent()
        setupRunAnimationComponent()
        setupAttackAnimationComponent()
        setupJumpAnimationComponent()
        setupHurtAnimationComponent()
        setupDeadAnimationComponent()
        setupPhysics()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWalkComponent()
    {
        trollWalkComponent = TrollWalkComponent(entity: self)
        addComponent(trollWalkComponent)
    }
    
    func setupRunComponent()
    {
        trollRunComponent = TrollRunComponent(entity: self)
        addComponent(trollRunComponent)
    }
    
    func setupIdleAnimationComponent()
    {
        var idleRightTextures:Array<SKTexture> = []
        var idleLeftTextures:Array<SKTexture> = []
        
        for i in 0...61
        {
            idleRightTextures.append(SKTexture(imageNamed: "\(trollName)_IdleRight\(i)"))
        }
        
        for i in 0...61
        {
            idleLeftTextures.append(SKTexture(imageNamed: "\(trollName)_IdleLeft\(i)"))
        }
        
        trollIdleAnimationComponent = TrollIdleAnimationComponent(entity: self, idleRightTextures: idleRightTextures, idleLeftTextures: idleLeftTextures)
        addComponent(trollIdleAnimationComponent)
    }
    
    func setupWalkAnimationComponent()
    {
        var walkRightTextures:Array<SKTexture> = []
        var walkLeftTextures:Array<SKTexture> = []
        
        for i in 0...61
        {
            walkRightTextures.append(SKTexture(imageNamed: "\(trollName)_WalkRight\(i)"))
        }
        
        for i in 0...61
        {
            walkLeftTextures.append(SKTexture(imageNamed: "\(trollName)_WalkLeft\(i)"))
        }
        
        trollWalkAnimationComponent = TrollWalkAnimationComponent(entity: self, walkRightTextures: walkRightTextures, walkLeftTextures: walkLeftTextures)
        addComponent(trollWalkAnimationComponent)
    }
    
    func setupRunAnimationComponent()
    {
        var runRightTextures:Array<SKTexture> = []
        var runLeftTextures:Array<SKTexture> = []
        
        for i in 0...61
        {
            runRightTextures.append(SKTexture(imageNamed: "\(trollName)_RunRight\(i)"))
        }
        
        for i in 0...61
        {
            runLeftTextures.append(SKTexture(imageNamed: "\(trollName)_RunLeft\(i)"))
        }
        
        trollRunAnimationComponent = TrollRunAnimationComponent(entity: self, runRightTextures: runRightTextures, runLeftTextures: runLeftTextures)
        addComponent(trollRunAnimationComponent)
    }
    
    func setupAttackAnimationComponent()
    {
        var attackRightTextures:Array<SKTexture> = []
        var attackLeftTextures:Array<SKTexture> = []
        
        for i in 0...61
        {
            attackRightTextures.append(SKTexture(imageNamed: "\(trollName)_AttackRight\(i)"))
        }
        
        for i in 0...61
        {
            attackLeftTextures.append(SKTexture(imageNamed: "\(trollName)_AttackLeft\(i)"))
        }
        
        trollAttackAnimationComponent = TrollAttackAnimationComponent(entity: self, attackRightTextures: attackRightTextures, attackLeftTextures: attackLeftTextures)
        addComponent(trollAttackAnimationComponent)
    }
    
    func setupJumpAnimationComponent()
    {
        var jumpRightTextures:Array<SKTexture> = []
        var jumpLeftTextures:Array<SKTexture> = []
        
        for i in 0...61
        {
            jumpRightTextures.append(SKTexture(imageNamed: "\(trollName)_JumpRight\(i)"))
        }
        
        for i in 0...61
        {
            jumpLeftTextures.append(SKTexture(imageNamed: "\(trollName)_JumpLeft\(i)"))
        }
        
        trollJumpAnimationComponent = TrollJumpAnimationComponent(entity: self, jumpRightTextures: jumpRightTextures, jumpLeftTextures: jumpLeftTextures)
               addComponent(trollJumpAnimationComponent)
    }
    
    func setupHurtAnimationComponent()
    {
        var hurtRightTextures:Array<SKTexture> = []
        var hurtLeftTextures:Array<SKTexture> = []
        
        for i in 0...61
        {
            hurtRightTextures.append(SKTexture(imageNamed: "\(trollName)_HurtRight\(i)"))
        }
        
        for i in 0...61
        {
            hurtLeftTextures.append(SKTexture(imageNamed: "\(trollName)_HurtLeft\(i)"))
        }
        
        trollHurtAnimationComponent = TrollHurtAnimationComponent(entity: self, hurtRightTextures: hurtRightTextures, hurtLeftTextures: hurtLeftTextures)
               addComponent(trollHurtAnimationComponent)
    }
    
    func setupDeadAnimationComponent()
    {
        var deadRightTextures:Array<SKTexture> = []
        var deadLeftTextures:Array<SKTexture> = []
        
        for i in 0...61
        {
            deadRightTextures.append(SKTexture(imageNamed: "\(trollName)_DeadRight\(i)"))
        }
        
        for i in 0...61
        {
            deadLeftTextures.append(SKTexture(imageNamed: "\(trollName)_DeadLeft\(i)"))
        }
        
        trollDeadAnimationComponent = TrollDeadAnimationComponent(entity: self, deadRightTextures: deadRightTextures, deadLeftTextures: deadLeftTextures)
               addComponent(trollDeadAnimationComponent)
    }
    
    func setupPhysics()
    {
        let spriteNode = spriteComponent.node
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: spriteNode.size.width/4, center: CGPoint(x: spriteNode.position.x, y: spriteNode.position.y - spriteNode.size.height/4))
        spriteNode.physicsBody?.isDynamic = true
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.allowsRotation = false
        
        // 0 is like glass to walk on.
        // 1 is like sandpaper to walk on.
        spriteNode.physicsBody?.friction = 0.0
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategory.Troll
        spriteNode.physicsBody?.collisionBitMask = 0
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
}
