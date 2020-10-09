// GameOverScene.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

class GameOverState : GKState
{
    unowned let scene: GameScene
    
    init(scene:SKScene)
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
    
    // This Method means that the only State that you can
    // move to is the GamePlayingState.
    override func isValidNextState(_ stateClass: AnyClass) -> Bool
    {
        return (stateClass is GamePlayingState.Type)
    }
    
    func setupScene()
    {
        scene.setupPanel()
        scene.setupSoundButton()
        
        // Downcasting
        let gameOverScene: GameOverScene = scene as! GameOverScene
        
        gameOverScene.setupBackground()
        gameOverScene.setupRetryButton()
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        
    }
}
