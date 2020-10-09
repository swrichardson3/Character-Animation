// GameScene.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

enum TrollState
{
    case idle, walk, run, attack, jump, hurt, dead
}

enum TrollDirection
{
    case left, right
}

class GamePlayingScene: GameScene
{
    var level1_ControllerStrip: LevelEntity!
    var level1_Road: LevelEntity!
    var level2_ControllerStrip: LevelEntity!
    var level2_Road: LevelEntity!
    var level3_ControllerStrip: LevelEntity!
    var level3_Road: LevelEntity!
    
    var backgroundEntity: BackgroundEntity!
    var landEntity: LandEntity!
    var homeButton: ButtonNode!
    var idleButton: ButtonNode!
    var walkButton: ButtonNode!
    var runButton: ButtonNode!
    var attackButton: ButtonNode!
    var jumpButton: ButtonNode!
    var hurtButton: ButtonNode!
    var deadButton: ButtonNode!
    var entities: [GKEntity] = []
    
    var isTroll1: Bool = false
    var isTroll2: Bool = false
    var isTroll3: Bool = false
    
    var isLevel1: Bool = false
    var isLevel2: Bool = false
    var isLevel3: Bool = false
    
    let buttonSpacing: CGFloat = 25.0

    var deltaTime: TimeInterval = 0
    var lastUpdateTime: TimeInterval = 0
    
    override init(size: CGSize, stateClass:AnyClass)
    {
        super.init(size: size, stateClass: stateClass)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLevel()
    {
        let diceRoll = arc4random_uniform(3)
        
        if(diceRoll == 0)
        {
            setupLevel1()
            isLevel1 = true
            isLevel2 = false
            isLevel3 = false
        }
        
        else if(diceRoll == 1)
        {
            setupLevel2()
            isLevel1 = false
            isLevel2 = true
            isLevel3 = false
        }
        
        else if(diceRoll == 2)
        {
            setupLevel3()
            isLevel1 = false
            isLevel2 = false
            isLevel3 = true
        }
    }
    
    private func setupLevel1()
    {
        self.backgroundColor = SKColor.black
        
        // Sky
        let level1_Sky = LevelEntity(imageName: SpriteName.level1_Sky)
        let level1_Sky_Node = level1_Sky.spriteComponent.node
        level1_Sky_Node.size.width = size.width
        level1_Sky_Node.size.height = size.height
        level1_Sky_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level1_Sky_Node.zPosition = Layer.Level_Layer1.rawValue
        level1_Sky_Node.name = "Level1_Sky"
        level1_Sky_Node.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        worldNode.addChild(level1_Sky_Node)
        
        // Background
        let level1_Background = LevelEntity(imageName: SpriteName.level1_Background)
        let level1_Background_Node = level1_Background.spriteComponent.node
        level1_Background_Node.size.width = size.width
        level1_Background_Node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        level1_Background_Node.zPosition = Layer.Level_Layer2.rawValue
        level1_Background_Node.name = "Level1_Background"
        level1_Background_Node.position = CGPoint(x: size.width * 0.5, y: size.height * 0.15)
        worldNode.addChild(level1_Background_Node)
        
        // ControllerStrip
        level1_ControllerStrip = LevelEntity(imageName: SpriteName.level1_ControllerStrip)
        let level1_ControllerStrip_Node = level1_ControllerStrip.spriteComponent.node
        level1_ControllerStrip_Node.size.width = size.width
        level1_ControllerStrip_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level1_ControllerStrip_Node.zPosition = Layer.Level_Layer3.rawValue
        level1_ControllerStrip_Node.name = "Level1_ControllerStrip"
        level1_ControllerStrip_Node.position = CGPoint(x: size.width * 0.5, y: level1_ControllerStrip_Node.size.height * 0.5)
        worldNode.addChild(level1_ControllerStrip_Node)
        
        // Road
        level1_Road = LevelEntity(imageName: SpriteName.level1_Road)
        let level1_Road_Node = level1_Road.spriteComponent.node
        level1_Road_Node.size.width = size.width
        level1_Road_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level1_Road_Node.zPosition = Layer.Level_Layer3.rawValue
        level1_Road_Node.name = "Level1_Road"
        level1_Road_Node.position = CGPoint(x: size.width * 0.5, y: level1_ControllerStrip_Node.size.height + level1_Road_Node.size.height * 0.5)
        worldNode.addChild(level1_Road_Node)
        
        // Ground
        let level1_Ground = LevelEntity(imageName: SpriteName.level1_Ground)
        let level1_Ground_Node = level1_Ground.spriteComponent.node
        level1_Ground_Node.size.width = size.width
        level1_Ground_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level1_Ground_Node.zPosition = Layer.Level_Layer3.rawValue
        level1_Ground_Node.name = "Level1_Ground"
        level1_Ground_Node.position = CGPoint(x: size.width * 0.5, y: level1_ControllerStrip_Node.size.height + level1_Road_Node.size.height + level1_Ground_Node.size.height * 0.5)
        worldNode.addChild(level1_Ground_Node)
        
        // Buildings
        let level1_Buildings = LevelEntity(imageName: SpriteName.level1_Buildings)
        let level1_Buildings_Node = level1_Buildings.spriteComponent.node
        level1_Buildings_Node.size.width = size.width
        level1_Buildings_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level1_Buildings_Node.zPosition = Layer.Level_Layer3.rawValue
        level1_Buildings_Node.name = "Level1_Buildings"
        level1_Buildings_Node.position = CGPoint(x: size.width * 0.5, y: level1_ControllerStrip_Node.size.height + level1_Road_Node.size.height + level1_Ground_Node.size.height + level1_Buildings_Node.size.height * 0.5)
        worldNode.addChild(level1_Buildings_Node)
        
        // Lights
        let level1_Lights = LevelEntity(imageName: SpriteName.level1_Lights)
        let level1_Lights_Node = level1_Lights.spriteComponent.node
        level1_Lights_Node.size.width = size.width
        level1_Lights_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level1_Lights_Node.zPosition = Layer.Level_Layer3.rawValue
        level1_Lights_Node.name = "Level1_Lights"
        level1_Lights_Node.position = CGPoint(x: size.width * 0.5, y: level1_ControllerStrip_Node.size.height + level1_Road_Node.size.height + level1_Ground_Node.size.height + level1_Lights_Node.size.height * 0.5)
        worldNode.addChild(level1_Lights_Node)
    }
    
    private func setupLevel2()
    {
        self.backgroundColor = SKColor.black
        
        // Sky
        let level2_Sky = LevelEntity(imageName: SpriteName.level2_Sky)
        let level2_Sky_Node = level2_Sky.spriteComponent.node
        level2_Sky_Node.size.width = size.width
        level2_Sky_Node.size.height = size.height
        level2_Sky_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level2_Sky_Node.zPosition = Layer.Level_Layer1.rawValue
        level2_Sky_Node.name = "Level2_Sky"
        level2_Sky_Node.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        worldNode.addChild(level2_Sky_Node)
        
        // Background
        let level2_Background = LevelEntity(imageName: SpriteName.level2_Background)
        let level2_Background_Node = level2_Background.spriteComponent.node
        level2_Background_Node.size.width = size.width
        level2_Background_Node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        level2_Background_Node.zPosition = Layer.Level_Layer2.rawValue
        level2_Background_Node.name = "Level2_Background"
        level2_Background_Node.position = CGPoint(x: size.width * 0.5, y: size.height * 0.15)
        worldNode.addChild(level2_Background_Node)
        
        // ControllerStrip
        level2_ControllerStrip = LevelEntity(imageName: SpriteName.level2_ControllerStrip)
        let level2_ControllerStrip_Node = level2_ControllerStrip.spriteComponent.node
        level2_ControllerStrip_Node.size.width = size.width
        level2_ControllerStrip_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level2_ControllerStrip_Node.zPosition = Layer.Level_Layer3.rawValue
        level2_ControllerStrip_Node.name = "Level2_ControllerStrip"
        level2_ControllerStrip_Node.position = CGPoint(x: size.width * 0.5, y: level2_ControllerStrip_Node.size.height * 0.5)
        worldNode.addChild(level2_ControllerStrip_Node)
        
        // Road
        level2_Road = LevelEntity(imageName: SpriteName.level2_Road)
        let level2_Road_Node = level2_Road.spriteComponent.node
        level2_Road_Node.size.width = size.width
        level2_Road_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level2_Road_Node.zPosition = Layer.Level_Layer3.rawValue
        level2_Road_Node.name = "Level2_Road"
        level2_Road_Node.position = CGPoint(x: size.width * 0.5, y: level2_ControllerStrip_Node.size.height + level2_Road_Node.size.height * 0.5)
        worldNode.addChild(level2_Road_Node)
        
        // Ground
        let level2_Ground = LevelEntity(imageName: SpriteName.level2_Ground)
        let level2_Ground_Node = level2_Ground.spriteComponent.node
        level2_Ground_Node.size.width = size.width
        level2_Ground_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level2_Ground_Node.zPosition = Layer.Level_Layer3.rawValue
        level2_Ground_Node.name = "Level1_Ground"
        level2_Ground_Node.position = CGPoint(x: size.width * 0.5, y: level2_ControllerStrip_Node.size.height + level2_Road_Node.size.height + level2_Ground_Node.size.height * 0.5)
        worldNode.addChild(level2_Ground_Node)
        
        // Buildings
        let level2_Buildings = LevelEntity(imageName: SpriteName.level2_Buildings)
        let level2_Buildings_Node = level2_Buildings.spriteComponent.node
        level2_Buildings_Node.size.width = size.width
        level2_Buildings_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level2_Buildings_Node.zPosition = Layer.Level_Layer3.rawValue
        level2_Buildings_Node.name = "Level2_Buildings"
        level2_Buildings_Node.position = CGPoint(x: size.width * 0.5, y: level2_ControllerStrip_Node.size.height + level2_Road_Node.size.height + level2_Ground_Node.size.height + level2_Buildings_Node.size.height * 0.5)
        worldNode.addChild(level2_Buildings_Node)
        
        // Lights
        let level2_Lights = LevelEntity(imageName: SpriteName.level2_Lights)
        let level2_Lights_Node = level2_Lights.spriteComponent.node
        level2_Lights_Node.size.width = size.width
        level2_Lights_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level2_Lights_Node.zPosition = Layer.Level_Layer3.rawValue
        level2_Lights_Node.name = "Level2_Lights"
        level2_Lights_Node.position = CGPoint(x: size.width * 0.5, y: level2_ControllerStrip_Node.size.height + level2_Road_Node.size.height + level2_Ground_Node.size.height + level2_Lights_Node.size.height * 0.5)
        worldNode.addChild(level2_Lights_Node)
    }
    
    private func setupLevel3()
    {
        self.backgroundColor = SKColor.black
        
        // Sky
        let level3_Sky = LevelEntity(imageName: SpriteName.level3_Sky)
        let level3_Sky_Node = level3_Sky.spriteComponent.node
        level3_Sky_Node.size.width = size.width
        level3_Sky_Node.size.height = size.height
        level3_Sky_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level3_Sky_Node.zPosition = Layer.Level_Layer1.rawValue
        level3_Sky_Node.name = "Level3_Sky"
        level3_Sky_Node.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        worldNode.addChild(level3_Sky_Node)
        
        // Background
        let level3_Background = LevelEntity(imageName: SpriteName.level3_Background)
        let level3_Background_Node = level3_Background.spriteComponent.node
        level3_Background_Node.size.width = size.width
        level3_Background_Node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        level3_Background_Node.zPosition = Layer.Level_Layer2.rawValue
        level3_Background_Node.name = "Level3_Background"
        level3_Background_Node.position = CGPoint(x: size.width * 0.5, y: size.height * 0.15)
        worldNode.addChild(level3_Background_Node)
        
        // ControllerStrip
        level3_ControllerStrip = LevelEntity(imageName: SpriteName.level3_ControllerStrip)
        let level3_ControllerStrip_Node = level3_ControllerStrip.spriteComponent.node
        level3_ControllerStrip_Node.size.width = size.width
        level3_ControllerStrip_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level3_ControllerStrip_Node.zPosition = Layer.Level_Layer3.rawValue
        level3_ControllerStrip_Node.name = "Level3_ControllerStrip"
        level3_ControllerStrip_Node.position = CGPoint(x: size.width * 0.5, y: level3_ControllerStrip_Node.size.height * 0.5)
        worldNode.addChild(level3_ControllerStrip_Node)
        
        // Road
        level3_Road = LevelEntity(imageName: SpriteName.level3_Road)
        let level3_Road_Node = level3_Road.spriteComponent.node
        level3_Road_Node.size.width = size.width
        level3_Road_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level3_Road_Node.zPosition = Layer.Level_Layer3.rawValue
        level3_Road_Node.name = "Level3_Road"
        level3_Road_Node.position = CGPoint(x: size.width * 0.5, y: level3_ControllerStrip_Node.size.height + level3_Road_Node.size.height * 0.5)
        worldNode.addChild(level3_Road_Node)
        
        // Ground
        let level3_Ground = LevelEntity(imageName: SpriteName.level3_Ground)
        let level3_Ground_Node = level3_Ground.spriteComponent.node
        level3_Ground_Node.size.width = size.width
        level3_Ground_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level3_Ground_Node.zPosition = Layer.Level_Layer3.rawValue
        level3_Ground_Node.name = "Level3_Ground"
        level3_Ground_Node.position = CGPoint(x: size.width * 0.5, y: level3_ControllerStrip_Node.size.height + level3_Road_Node.size.height + level3_Ground_Node.size.height * 0.5)
        worldNode.addChild(level3_Ground_Node)
        
        // Buildings
        let level3_Buildings = LevelEntity(imageName: SpriteName.level3_Buildings)
        let level3_Buildings_Node = level3_Buildings.spriteComponent.node
        level3_Buildings_Node.size.width = size.width
        level3_Buildings_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level3_Buildings_Node.zPosition = Layer.Level_Layer3.rawValue
        level3_Buildings_Node.name = "Level3_Buildings"
        level3_Buildings_Node.position = CGPoint(x: size.width * 0.5, y: level3_ControllerStrip_Node.size.height + level3_Road_Node.size.height + level3_Ground_Node.size.height + level3_Buildings_Node.size.height * 0.5)
        worldNode.addChild(level3_Buildings_Node)
        
        // Lights
        let level3_Lights = LevelEntity(imageName: SpriteName.level3_Lights)
        let level3_Lights_Node = level3_Lights.spriteComponent.node
        level3_Lights_Node.size.width = size.width
        level3_Lights_Node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        level3_Lights_Node.zPosition = Layer.Level_Layer3.rawValue
        level3_Lights_Node.name = "Level3_Lights"
        level3_Lights_Node.position = CGPoint(x: size.width * 0.5, y: level3_ControllerStrip_Node.size.height + level3_Road_Node.size.height + level3_Ground_Node.size.height + level3_Lights_Node.size.height * 0.5)
        worldNode.addChild(level3_Lights_Node)
    }
    
    func setupTroll()
    {
        let result = getTroll()
        
        isTroll1 = result.troll1
        isTroll2 = result.troll2
        isTroll3 = result.troll3
        
        let level_Road_Node = getRoadNode()
        var spriteName: String = ""
        var trollName: String = ""
        let diceRoll = arc4random_uniform(2)
        
        if(isTroll1)
        {
            trollName  = "Troll1"
            
            if(diceRoll == 0)
            {
                spriteName = SpriteName.troll1_IdleRight0
            }
            
            else
            {
                spriteName = SpriteName.troll1_IdleLeft0
            }
        }
        
        if(isTroll2)
        {
            trollName  = "Troll2"
            
            if(diceRoll == 0)
            {
                spriteName = SpriteName.troll2_IdleRight0
            }
            
            else
            {
                spriteName = SpriteName.troll2_IdleLeft0
            }
        }
        
        if(isTroll3)
        {
            trollName  = "Troll3"
            
            if(diceRoll == 0)
            {
                spriteName = SpriteName.troll3_IdleRight0
            }
            
            else
            {
                spriteName = SpriteName.troll3_IdleLeft0
            }
        }
        
        let trolls: [String: Troll] = LevelMap.sharedInstance().trolls
        let troll: Troll = trolls[trollName]!
        
        let trollEntity = TrollEntity(scene: self, imageName: spriteName, trollName: trollName)
        let trollNode = trollEntity.spriteComponent.node
        
        trollEntity.trollWalkComponent.trollWalkSpeed = CGFloat(troll.walkSpeed)
        trollEntity.trollWalkComponent.minPositionX = trollNode.size.width/2
        trollEntity.trollWalkComponent.maxPositionX = size.width - trollNode.size.width/2
        
        trollEntity.trollRunComponent.trollRunSpeed = CGFloat(troll.runSpeed)
        trollEntity.trollRunComponent.minPositionX = trollNode.size.width/2
        trollEntity.trollRunComponent.maxPositionX = size.width - trollNode.size.width/2
        
        trollEntity.trollState = .idle
        trollEntity.trollDirection = (spriteName == SpriteName.troll1_IdleRight0) || (spriteName == SpriteName.troll2_IdleRight0) || (spriteName == SpriteName.troll3_IdleRight0) ? .right : .left
        
        trollNode.position = CGPoint(x: size.width/2, y: level_Road_Node.position.y + trollNode.size.height/2)
        trollNode.zPosition = Layer.Troll.rawValue
        trollNode.name = troll.trollName
        worldNode.addChild(trollNode)
        
        updateTrollState()
    }
    
    func setupHomeButton()
    {
        let panelNode = panelEntity.spriteComponent.node
        
        // Home Button.
        homeButton = ButtonNode(defaultButtonImage: SpriteName.homeButtonDefault, activeButtonImage: SpriteName.homeButtonActive, onButtonPress: homeButtonPressed)
        homeButton.position = CGPoint(x: homeButton.size.width, y: panelNode.position.y)
        homeButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(homeButton)
    }
    
    private func homeButtonPressed()
    {
        homeButton.isUserInteractionEnabled = false
        soundButton.isUserInteractionEnabled = false
        
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        nextScene(GameStartState.self)
    }
    
    func nextScene(_ stateClass: AnyClass)
    {
        if(stateClass == GameStartState.self)
        {
            let newScene = GameStartScene(size: size, stateClass: stateClass)
            let transition = SKTransition.fade(with: SKColor.black, duration: 0.02)
            view?.presentScene(newScene, transition: transition)
        }
        
        if(stateClass == GameOverState.self)
        {
            let newScene = GameOverScene(size: size, stateClass: stateClass)
            let transition = SKTransition.fade(with: SKColor.black, duration: 0.02)
            view?.presentScene(newScene, transition: transition)
        }
    }
    
    func setupControllerButtons()
    {
        setupIdleButton()
        setupWalkButton()
        setupRunButton()
        setupJumpButton()
        setupAttackButton()
        setupHurtButton()
        setupDeadButton()
    }
    
    private func setupIdleButton()
    {
        let level1_ControllerStrip_Node = getControllerStripNode()
        
        // Idle Button.
        idleButton = ButtonNode(defaultButtonImage: SpriteName.idleButtonDefault, activeButtonImage: SpriteName.idleButtonActive, onButtonPress: idleButtonPressed)
        idleButton.position = CGPoint(x: size.width * 0.5 - idleButton.size.width * 3 - buttonSpacing * 3, y: level1_ControllerStrip_Node.position.y)
        idleButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(idleButton)
    }
    
    private func setupWalkButton()
    {
        let level1_ControllerStrip_Node = getControllerStripNode()
        
        // Walk Button.
        walkButton = ButtonNode(defaultButtonImage: SpriteName.walkButtonDefault, activeButtonImage: SpriteName.walkButtonActive, onButtonPress: walkButtonPressed)
        walkButton.position = CGPoint(x: size.width * 0.5 - walkButton.size.width * 2 - buttonSpacing * 2, y: level1_ControllerStrip_Node.position.y)
        walkButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(walkButton)
    }
    
    private func setupRunButton()
    {
        let level1_ControllerStrip_Node = getControllerStripNode()
        
        // Run Button.
        runButton = ButtonNode(defaultButtonImage: SpriteName.runButtonDefault, activeButtonImage: SpriteName.runButtonActive, onButtonPress: runButtonPressed)
        runButton.position = CGPoint(x: size.width * 0.5 - runButton.size.width - buttonSpacing, y: level1_ControllerStrip_Node.position.y)
        runButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(runButton)
    }
    
    private func setupJumpButton()
    {
        let level1_ControllerStrip_Node = getControllerStripNode()
        
        // Jump Button.
        jumpButton = ButtonNode(defaultButtonImage: SpriteName.jumpButtonDefault, activeButtonImage: SpriteName.jumpButtonActive, onButtonPress: jumpButtonPressed)
        jumpButton.position = CGPoint(x: size.width/2, y: level1_ControllerStrip_Node.position.y)
        jumpButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(jumpButton)
    }
    
    private func setupAttackButton()
    {
        let level1_ControllerStrip_Node = getControllerStripNode()
        
        // Attack Button.
        attackButton = ButtonNode(defaultButtonImage: SpriteName.attackButtonDefault, activeButtonImage: SpriteName.attackButtonActive, onButtonPress: attackButtonPressed)
        attackButton.position = CGPoint(x: size.width * 0.5 + attackButton.size.width + buttonSpacing, y: level1_ControllerStrip_Node.position.y)
        attackButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(attackButton)
    }
    
    private func setupHurtButton()
    {
        let level1_ControllerStrip_Node = getControllerStripNode()
        
        // Hurt Button.
        hurtButton = ButtonNode(defaultButtonImage: SpriteName.hurtButtonDefault, activeButtonImage: SpriteName.hurtButtonActive, onButtonPress: hurtButtonPressed)
        hurtButton.position = CGPoint(x: size.width * 0.5 + hurtButton.size.width * 2 + buttonSpacing * 2, y: level1_ControllerStrip_Node.position.y)
        hurtButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(hurtButton)
    }
    
    private func setupDeadButton()
    {
        let level1_ControllerStrip_Node = getControllerStripNode()
        
        // Dead Button.
        deadButton = ButtonNode(defaultButtonImage: SpriteName.deadButtonDefault, activeButtonImage: SpriteName.deadButtonActive, onButtonPress: deadButtonPressed)
        deadButton.position = CGPoint(x: size.width * 0.5 + deadButton.size.width * 3 + buttonSpacing * 3, y: level1_ControllerStrip_Node.position.y)
        deadButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(deadButton)
    }
    
    private func idleButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.trollState = .idle
            }
        }
        
        updateTrollState()
    }
    
    private func walkButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.trollState = .walk
            }
        }
        
        updateTrollState()
    }
    
    private func runButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.trollState = .run
            }
        }
        
        updateTrollState()
    }
    
    private func jumpButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.trollState = .jump
            }
        }
        
        updateTrollState()
    }
    
    private func attackButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.trollState = .attack
            }
        }
        
        updateTrollState()
    }
    
    private func hurtButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.trollState = .hurt
            }
        }
        
        updateTrollState()
    }
    
    private func deadButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.trollState = .dead
            }
        }
        
        updateTrollState()
    }
    
    private func getRoadNode() -> SKSpriteNode
    {
        let level_Road_Node: SKSpriteNode = isLevel1 ? level1_Road.spriteComponent.node : (isLevel2 ? level2_Road.spriteComponent.node : level3_Road.spriteComponent.node)
        
        return level_Road_Node
    }
    
    private func getControllerStripNode() -> SKSpriteNode
    {
        let level_ControllerStrip_Node: SKSpriteNode = isLevel1 ? level1_ControllerStrip.spriteComponent.node : (isLevel2 ? level2_ControllerStrip.spriteComponent.node : level3_ControllerStrip.spriteComponent.node)
        return level_ControllerStrip_Node
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }

    override func update(_ currentTime: TimeInterval)
    {
        if (self.lastUpdateTime == 0)
        {
            self.lastUpdateTime = currentTime
        }
        
        deltaTime = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        // Begin updates
        stateMachine.update(deltaTime: deltaTime)
        
        // This will update all Components in the Troll Entity.
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                trollEntity.update(deltaTime: deltaTime)
            }
        }
    }
    
    func updateTrollState()
    {
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                
                switch trollEntity.trollState
                {
                case .idle:
                    if(trollEntity.trollDirection == .right)
                    {
                        stopAnimation()
                        trollEntity.trollIdleAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                    if(trollEntity.trollDirection == .left)
                    {
                        stopAnimation()
                        trollEntity.trollIdleAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                    
                case .walk:
                    if(trollEntity.trollDirection == .right)
                    {
                        stopAnimation()
                        trollEntity.trollWalkAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = true
                        trollEntity.runAllowed = false
                    }
                    
                    if(trollEntity.trollDirection == .left)
                    {
                        stopAnimation()
                        trollEntity.trollWalkAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = true
                        trollEntity.runAllowed = false
                    }
                    
                case .run:
                    if(trollEntity.trollDirection == .right)
                    {
                        stopAnimation()
                        trollEntity.trollRunAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = true
                    }
                    
                    if(trollEntity.trollDirection == .left)
                    {
                        stopAnimation()
                        trollEntity.trollRunAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = true
                    }
                    
                case .attack:
                    if(trollEntity.trollDirection == .right)
                    {
                        stopAnimation()
                        trollEntity.trollAttackAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                    if(trollEntity.trollDirection == .left)
                    {
                        stopAnimation()
                        trollEntity.trollAttackAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                case .jump:
                    if(trollEntity.trollDirection == .right)
                    {
                        stopAnimation()
                        trollEntity.trollJumpAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                    if(trollEntity.trollDirection == .left)
                    {
                        stopAnimation()
                        trollEntity.trollJumpAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                case .hurt:
                    if(trollEntity.trollDirection == .right)
                    {
                        stopAnimation()
                        trollEntity.trollHurtAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                    if(trollEntity.trollDirection == .left)
                    {
                        stopAnimation()
                        trollEntity.trollHurtAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                case .dead:
                    if(trollEntity.trollDirection == .right)
                    {
                        stopAnimation()
                        trollEntity.trollDeadAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                    
                    if(trollEntity.trollDirection == .left)
                    {
                        stopAnimation()
                        trollEntity.trollDeadAnimationComponent.playAnimation()
                        trollEntity.walkAllowed = false
                        trollEntity.runAllowed = false
                    }
                }
            }
        }
    }
    
    private func stopAnimation()
    {
        for i in 0..<entities.count
        {
            if(entities[i] is TrollEntity)
            {
                let trollEntity = entities[i] as! TrollEntity
                
                trollEntity.trollIdleAnimationComponent.stopAnimation("IdleRight")
                trollEntity.trollIdleAnimationComponent.stopAnimation("IdleLeft")
                trollEntity.trollWalkAnimationComponent.stopAnimation("WalkRight")
                trollEntity.trollWalkAnimationComponent.stopAnimation("WalkLeft")
                trollEntity.trollRunAnimationComponent.stopAnimation("RunRight")
                trollEntity.trollRunAnimationComponent.stopAnimation("RunLeft")
                trollEntity.trollAttackAnimationComponent.stopAnimation("AttackRight")
                trollEntity.trollAttackAnimationComponent.stopAnimation("AttackLeft")
                trollEntity.trollJumpAnimationComponent.stopAnimation("JumpRight")
                trollEntity.trollJumpAnimationComponent.stopAnimation("JumpLeft")
                trollEntity.trollHurtAnimationComponent.stopAnimation("HurtRight")
                trollEntity.trollHurtAnimationComponent.stopAnimation("HurtLeft")
                trollEntity.trollDeadAnimationComponent.stopAnimation("DeadRight")
                trollEntity.trollDeadAnimationComponent.stopAnimation("DeadLeft")
            }
        }
    }
    
    func addEntity(entity: GKEntity)
    {
        entities.append(entity)
    }
}

extension GameScene : SKPhysicsContactDelegate
{
    func didBegin(_ contact: SKPhysicsContact)
    {
        
    }
}
