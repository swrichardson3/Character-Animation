// GameOverScene.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class GameOverScene: GameScene
{
    var backgroundEntity: BackgroundEntity!
    var retryButton: ButtonNode!
    
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
        // Background.
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
    
    func setupRetryButton()
    {
        // Retry Button.
        retryButton = ButtonNode(defaultButtonImage: SpriteName.retryButtonDefault, activeButtonImage: SpriteName.retryButtonActive, onButtonPress: retryButtonPressed)
        retryButton.position = CGPoint(x: size.width/2, y: size.height/2)
        retryButton.zPosition = Layer.UI.rawValue
        worldNode.addChild(retryButton)
    }
    
    func retryButtonPressed()
    {
        let buttonSound = soundManager.buttonAudioAction
        self.run(buttonSound)
        
        nextScene(GameStartState.self)
    }
    
    func nextScene(_ stateClass: AnyClass)
    {
        let newScene = GameStartScene(size: size, stateClass: stateClass)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.02)
        view?.presentScene(newScene, transition: transition)
    }
}
