// GameScene.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

enum Layer: CGFloat
{
    case Background
    case Level_Layer1
    case Level_Layer2
    case Level_Layer3
    case Level_Layer4
    case Panel
    case Player
    case Troll
    case UI
}

class GameScene: SKScene
{
    var initialState: AnyClass
    var panelEntity: PanelEntity!
    var soundButton: CheckBoxNode!
    var fontName = "walibi0615"
    
    let soundManager: SoundManager = SoundManager.sharedInstance
    
    let worldNode = SKNode()
    
    var soundOn = false {
      didSet {
        if (soundOn)
        {
            SKTAudio.sharedInstance().resumeMusic()
        }
        
        else
        {
            SKTAudio.sharedInstance().pauseMusic()
        }
        
        UserDefaults.standard.set(soundOn, forKey: "SoundActive")
        UserDefaults.standard.synchronize()
      }
    }
    
    // Set up the State Machine.
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        GameStartState(scene: self),
        GamePlayingState(scene: self),
        GameOverState(scene: self)
        ])
    
    var contentCreated = false
    
    init(size: CGSize, stateClass:AnyClass)
    {
        initialState = stateClass
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView)
    {
        if(!self.contentCreated)
        {
            addChild(worldNode)
            
            createContent()
            self.contentCreated = true
        }
    }
    
    func createContent()
    {
        stateMachine.enter(initialState)
    }
    
    func setupPanel()
    {
        panelEntity = PanelEntity(imageName: SpriteName.panel)
        let panelNode = panelEntity.spriteComponent.node
        panelNode.size.width = size.width
        panelNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        panelNode.alpha = 0.75
        panelNode.zPosition = Layer.Panel.rawValue
        panelNode.name = "Panel"
        panelNode.position = CGPoint(x: size.width/2, y: size.height - panelNode.size.height/2)
        worldNode.addChild(panelNode)
    }
    
    func setupSoundButton()
    {
        let panelNode = panelEntity.spriteComponent.node
        
        // Pause Button.
        soundButton = CheckBoxNode(uncheckedButtonImage: SpriteName.soundButtonUnchecked, checkedButtonImage: SpriteName.soundButtonChecked, buttonAction: soundButtonPressed)
        soundButton.position = CGPoint(x: size.width - soundButton.uncheckedButton.size.width, y: panelNode.position.y)
        soundButton.name = "MusicButton"
        soundButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(soundButton)
        
        soundOn = UserDefaults.standard.bool(forKey: "SoundActive")
        soundButton.uncheckedButton.isHidden = soundOn ? false : true
        soundButton.checkedButton.isHidden = soundOn ? true : false
    }
    
    func soundButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        soundOn = !soundOn
        
        /*if (musicPaused)
        {
            SKTAudio.sharedInstance().pauseMusic()
        }
        
        else
        {
            SKTAudio.sharedInstance().resumeMusic()
        }*/
    }
    
    func setTroll(troll1: Bool, troll2: Bool, troll3: Bool)
    {
        UserDefaults.standard.set(troll1, forKey: "Troll1")
        UserDefaults.standard.set(troll2, forKey: "Troll2")
        UserDefaults.standard.set(troll3, forKey: "Troll3")
        UserDefaults.standard.synchronize()
    }
    
    func getTroll() -> (troll1: Bool, troll2: Bool, troll3: Bool)
    {
        return (UserDefaults.standard.bool(forKey: "Troll1"), UserDefaults.standard.bool(forKey: "Troll2"), UserDefaults.standard.bool(forKey: "Troll3"))
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
}
