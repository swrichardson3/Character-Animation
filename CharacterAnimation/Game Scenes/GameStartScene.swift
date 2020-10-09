// GameStartScene.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class GameStartScene: GameScene
{
    var backgroundEntity: BackgroundEntity!
    var informationButton: ButtonNode!
    var tutorialButton: ButtonNode!
    var troll1Button: ButtonNode!
    var troll2Button: ButtonNode!
    var troll3Button: ButtonNode!
    
    override init(size: CGSize, stateClass: AnyClass)
    {
        super.init(size: size, stateClass: stateClass)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackground()
    {
        self.backgroundColor = SKColor.black
        
        // Background Entity.
        backgroundEntity = BackgroundEntity(imageName: SpriteName.background)
        let backgroundNode = backgroundEntity.spriteComponent.node
        backgroundNode.size.width = size.width
        backgroundNode.size.height = size.height
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundNode.zPosition = Layer.Background.rawValue
        backgroundNode.name = "Background"
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        worldNode.addChild(backgroundNode)
    }
    
    func setupTitle()
    {
        let panelNode = panelEntity.spriteComponent.node
        
        // ScoreLabel Entity.
        let titleLabelEntity = LabelEntity(fontName: fontName)
        let titleLabelNode = titleLabelEntity.labelComponent.node
        //scoreLabelNode.fontColor = SKColor(red: 233.0/255.0, green: 252.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        titleLabelNode.fontColor = Colors.colorFrom(rgb: Colors.score)
        
        if (UIDevice.current.userInterfaceIdiom == .phone)
        {
            titleLabelNode.fontSize = 50.0
        }
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            titleLabelNode.fontSize = 100.0
        }
        
        titleLabelNode.text = "Choose Troll"
        titleLabelNode.zPosition = Layer.UI.rawValue
        
        titleLabelNode.position = CGPoint(x: size.width/2, y: size.height - panelNode.size.height - titleLabelNode.frame.size.height - 20)
        worldNode.addChild(titleLabelNode)
    }
    
    func setupInformationButton()
    {
        let panelNode = panelEntity.spriteComponent.node
        
        // Information Button.
        informationButton = ButtonNode(defaultButtonImage: SpriteName.informationButtonDefault, activeButtonImage: SpriteName.informationButtonActive, onButtonPress: informationButtonPressed)
        informationButton.position = CGPoint(x: informationButton.size.width, y: panelNode.position.y)
        informationButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(informationButton)
    }
    
    func informationButtonPressed()
    {
        informationButton.isUserInteractionEnabled = false
        tutorialButton.isUserInteractionEnabled = false
        soundButton.isUserInteractionEnabled = false
        troll1Button.isUserInteractionEnabled = false
        troll2Button.isUserInteractionEnabled = false
        troll3Button.isUserInteractionEnabled = false
        
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        self.run(buttonSound, completion: {
            let informationDialogBox = InformationDialogBox(scene: self, boardBackgroundImage: SpriteName.infoDialogBox, boardPositionFromCenter: CGPoint(x: 0, y: 0), boardWidth: self.view!.bounds.width * 0.35, backgroundViewAlpha: 0.5)
            self.view!.addSubview(informationDialogBox)
        })
    }
    
    func setupTutorialButton()
    {
        let panelNode = panelEntity.spriteComponent.node
        
        // Tutorial Button.
        tutorialButton = ButtonNode(defaultButtonImage: SpriteName.tutorialButtonDefault, activeButtonImage: SpriteName.tutorialButtonActive, onButtonPress: tutorialButtonPressed)
        tutorialButton.position = CGPoint(x: informationButton.position.x + informationButton.size.width/2 + tutorialButton.size.width/2 + CGFloat(10), y: panelNode.position.y)
        tutorialButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(tutorialButton)
    }
    
    func tutorialButtonPressed()
    {
        informationButton.isUserInteractionEnabled = false
        tutorialButton.isUserInteractionEnabled = false
        soundButton.isUserInteractionEnabled = false
        troll1Button.isUserInteractionEnabled = false
        troll2Button.isUserInteractionEnabled = false
        troll3Button.isUserInteractionEnabled = false
        
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        self.run(buttonSound, completion: {
            let tutorialDialogBox = TutorialDialogBox(scene: self, boardBackgroundImage: SpriteName.tutorialDialogBox, boardPositionFromCenter: CGPoint(x: 0, y: 0), boardWidth: self.view!.bounds.width * 0.35, backgroundViewAlpha: 0.5)
            self.view!.addSubview(tutorialDialogBox)
        })
    }
    
    func setupTroll1Button()
    {
        // Troll1 Button.
        troll1Button = ButtonNode(defaultButtonImage: SpriteName.troll1ButtonDefault, activeButtonImage: SpriteName.troll1ButtonActive, onButtonPress: troll1ButtonPressed)
        
        let aspectRatio = troll1Button.size.height/troll1Button.size.width
        troll1Button.size.width = size.width * 0.25
        troll1Button.size.height = aspectRatio * troll1Button.size.width
        let spacing = troll1Button.size.width * 0.25
        troll1Button.position = CGPoint(x: (troll1Button.size.width * 0.5) + spacing, y: size.height * 0.5)
        troll1Button.zPosition = Layer.UI.rawValue
        worldNode.addChild(troll1Button)
    }
    
    func setupTroll2Button()
    {
        // Troll2 Button.
        troll2Button = ButtonNode(defaultButtonImage: SpriteName.troll2ButtonDefault, activeButtonImage: SpriteName.troll2ButtonActive, onButtonPress: troll2ButtonPressed)
        
        let aspectRatio = troll2Button.size.height/troll2Button.size.width
        troll2Button.size.width = size.width * 0.25
        troll2Button.size.height = aspectRatio * troll2Button.size.width
        troll2Button.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        troll2Button.zPosition = Layer.UI.rawValue
        worldNode.addChild(troll2Button)
    }
    
    func setupTroll3Button()
    {
        // Troll3 Button.
        troll3Button = ButtonNode(defaultButtonImage: SpriteName.troll3ButtonDefault, activeButtonImage: SpriteName.troll3ButtonActive, onButtonPress: troll3ButtonPressed)
        
        let aspectRatio = troll3Button.size.height/troll3Button.size.width
        troll3Button.size.width = size.width * 0.25
        troll3Button.size.height = aspectRatio * troll3Button.size.width
        let spacing = troll3Button.size.width * 0.25
        troll3Button.position = CGPoint(x: size.width - (troll3Button.size.width * 0.5) - spacing, y: size.height * 0.5)
        troll3Button.zPosition = Layer.UI.rawValue
        worldNode.addChild(troll3Button)
    }
    
    func troll1ButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        setTroll(troll1: true, troll2: false, troll3: false)
        
        nextScene(GamePlayingState.self)
    }
    
    func troll2ButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        setTroll(troll1: false, troll2: true, troll3: false)
        
        nextScene(GamePlayingState.self)
    }
    
    func troll3ButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        setTroll(troll1: false, troll2: false, troll3: true)
        
        nextScene(GamePlayingState.self)
    }
    
    func nextScene(_ stateClass: AnyClass)
    {
        let newScene = GamePlayingScene(size: size, stateClass: stateClass)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.02)
        view?.presentScene(newScene, transition: transition)
    }
}
