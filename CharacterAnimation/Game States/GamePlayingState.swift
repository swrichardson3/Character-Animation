//  GamePlayingScene.swift
//  CharacterAnimation
import SpriteKit
import GameplayKit

class GamePlayingState : GKState
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
    
    // This Method means that the only State that you can
    // move to is the GameStartState or GameOverState.
    override func isValidNextState(_ stateClass: AnyClass) -> Bool
    {
        return (stateClass is GameStartState.Type) || (stateClass is GameOverState.Type)
    }
    
    func setupScene()
    {
        scene.setupPanel()
        scene.setupSoundButton()
        
        // Downcasting
        let gamePlayingScene: GamePlayingScene = scene as! GamePlayingScene
        
        gamePlayingScene.setupLevel()
        gamePlayingScene.setupTroll()
        gamePlayingScene.setupHomeButton()
        gamePlayingScene.setupControllerButtons()
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
    
    }
}
