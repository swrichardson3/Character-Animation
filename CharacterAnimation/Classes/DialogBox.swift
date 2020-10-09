// DialogBox.swift
// CharacterAnimation
import UIKit
import SpriteKit

class DialogBox : UIView
{
    var backgroundView : UIView!
    var scene : SKScene!
    var board: UIView!
    var boardBackgroundImage: String!
    var boardPositionFromCenter: CGPoint!
    var boardWidth: CGFloat!
    var backgroundViewAlpha: CGFloat!

    init(scene: SKScene, boardBackgroundImage: String, boardPositionFromCenter: CGPoint, boardWidth: CGFloat, backgroundViewAlpha: CGFloat)
    {
        super.init(frame: scene.view!.bounds)

        self.scene = scene
        self.boardBackgroundImage = boardBackgroundImage
        self.boardPositionFromCenter = boardPositionFromCenter
        self.boardWidth = boardWidth
        self.backgroundViewAlpha = backgroundViewAlpha
        
        self.scene.view!.isPaused = true
        self.scene.isUserInteractionEnabled = false
        self.layer.zPosition = Layer.UI.rawValue
        
        setupBackgroundView()
        setupBoard()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func setupBackgroundView()
    {
        backgroundView = UIView(frame: scene.view!.bounds)
        backgroundView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: backgroundViewAlpha)
        backgroundView.layer.position = scene.view!.center
        addSubview(backgroundView)
    }
    
    func setupBoard()
    {
        let dialogBoxImage: UIImage = UIImage(named: boardBackgroundImage)!
        let aspectRatio = dialogBoxImage.size.height/dialogBoxImage.size.width
        let boardHeight = aspectRatio * boardWidth
        board = UIView(frame: CGRect(x: 0, y: 0, width: boardWidth, height: boardHeight))
        let resizedImage = dialogBoxImage.resized(to: CGSize(width: boardWidth, height: boardHeight))
        board.backgroundColor = UIColor(patternImage: resizedImage)
        board.layer.position = backgroundView.center + boardPositionFromCenter
        addSubview(board)
    }
}
