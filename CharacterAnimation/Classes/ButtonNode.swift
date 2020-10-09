// ButtonNode.swift
// CharacterAnimation
import Foundation
import SpriteKit

class ButtonNode : SKSpriteNode
{
    let defaultButton: SKTexture
    let activeButton: SKTexture
    var isPressed: Bool = false
    let onButtonPress: () -> ()
    
    var isSelected: Bool = false
    {
        didSet{
            texture = isSelected ? activeButton : defaultButton
        }
    }
    
    init(defaultButtonImage: String, activeButtonImage: String, onButtonPress: @escaping () -> ())
    {
        defaultButton = SKTexture(imageNamed: defaultButtonImage)
        activeButton = SKTexture(imageNamed: activeButtonImage)
        self.onButtonPress = onButtonPress
        
        super.init(texture: defaultButton, color: SKColor.white, size: defaultButton.size())
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        isSelected = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            let touchLocation = touch.location(in: parent!)
            
            if(frame.contains(touchLocation))
            {
                isSelected = true
            }
            
            else
            {
                isSelected = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            let touchLocation = touch.location(in: parent!)
            
            if(frame.contains(touchLocation))
            {
                onButtonPress()
            }
                
            isSelected = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       
    }
}
