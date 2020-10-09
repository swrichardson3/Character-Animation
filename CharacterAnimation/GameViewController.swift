// GameViewController.swift
// CharacterAnimation
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameStartScene(size: view.bounds.size, stateClass:GameStartState.self)
            scene.scaleMode = .aspectFill
            
            LevelMap.sharedInstance().loadJSON(filename: "Trolls")
            SKTAudio.sharedInstance().playMusic(filename: "Santana-Put_Your_Lights_On.mp3")
            
            view.ignoresSiblingOrder = false
            
            // This will show the Physics Borderline.
            //view.showsPhysics = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
            view.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        }
        
        else
        {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
