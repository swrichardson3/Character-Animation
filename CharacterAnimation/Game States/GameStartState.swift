// GameStartState.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class GameStartState: GKState
{
    unowned let scene: GameScene

    init(scene: SKScene)
    {
        self.scene = scene as! GameScene
        super.init()
    }
    
    // This Method runs just before it enters this State.
    override func didEnter(from previousState: GKState?)
    {
        setupScene()
    }
    
    override func willExit(to nextState: GKState)
    {
        
    }
    
    // This method means that the only state that you can move
    // to is the GamePlayingState.
    override func isValidNextState(_ stateClass: AnyClass) -> Bool
    {
        return (stateClass is GamePlayingState.Type)
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        
    }
    
    func setupScene()
    {
        scene.setupPanel()
        scene.setupSoundButton()
        
        // Downcasting
        let gameStartScene: GameStartScene = scene as! GameStartScene
        
        gameStartScene.setupBackground()
        gameStartScene.setupTitle()
        gameStartScene.setupInformationButton()
        gameStartScene.setupTutorialButton()
        gameStartScene.setupTroll1Button()
        gameStartScene.setupTroll2Button()
        gameStartScene.setupTroll3Button()
    }
}
