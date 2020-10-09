// TutorialDialogBox.swift
// CharacterAnimation
import UIKit
import SpriteKit

class TutorialDialogBox: DialogBox
{
    override init(scene: SKScene, boardBackgroundImage: String, boardPositionFromCenter: CGPoint, boardWidth: CGFloat, backgroundViewAlpha: CGFloat)
    {
        super.init(scene: scene, boardBackgroundImage: boardBackgroundImage, boardPositionFromCenter: boardPositionFromCenter, boardWidth: boardWidth, backgroundViewAlpha: backgroundViewAlpha)
        
        setupExitButton()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupExitButton()
    {
        let exitButton = UIButton(type: UIButton.ButtonType.custom)
        let exitButtonImageDefault = UIImage(named: SpriteName.exitButtonDefault)
        let exitButtonImageActive = UIImage(named: SpriteName.exitButtonActive)
        exitButton.setBackgroundImage(exitButtonImageDefault, for: UIControl.State.normal)
        exitButton.setBackgroundImage(exitButtonImageActive, for: UIControl.State.highlighted)
        exitButton.setBackgroundImage(exitButtonImageActive, for: UIControl.State.selected)
        exitButton.frame.size.width = exitButtonImageDefault!.size.width
        exitButton.frame.size.height = exitButtonImageDefault!.size.height
        exitButton.contentMode = UIView.ContentMode.scaleToFill
        
        if (UIDevice.current.userInterfaceIdiom == .phone)
        {
            exitButton.layer.position = CGPoint(x: board.bounds.maxX - 0.8 * exitButton.bounds.width, y: 0.8 * exitButton.bounds.height)
        }
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            exitButton.layer.position = CGPoint(x: board.bounds.maxX - exitButton.bounds.width, y: exitButton.bounds.height)
        }
        
        exitButton.addTarget(self, action: #selector(self.onExitButton(sender:)), for: UIControl.Event.touchUpInside)
        board.addSubview(exitButton)
    }
    
    @objc func onExitButton(sender: UIButton)
    {
        self.scene.view!.isPaused = false
        self.scene.isUserInteractionEnabled = true
        
        let gameStartScene: GameStartScene = scene as! GameStartScene
        gameStartScene.informationButton.isUserInteractionEnabled = true
        gameStartScene.tutorialButton.isUserInteractionEnabled = true
        gameStartScene.soundButton.isUserInteractionEnabled = true
        gameStartScene.troll1Button.isUserInteractionEnabled = true
        gameStartScene.troll2Button.isUserInteractionEnabled = true
        gameStartScene.troll3Button.isUserInteractionEnabled = true
        
        self.removeFromSuperview()
    }
}
