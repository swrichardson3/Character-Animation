// CheckBox.swift
// CharacterAnimation
import UIKit
import SpriteKit

class CheckBoxNode: SKNode
{
    var uncheckedButton: SKSpriteNode
    var checkedButton: SKSpriteNode
    var action: () -> Void
    
    var isChecked: Bool = false {
        didSet {
            if(isChecked)
            {
                //uncheckedButton.isHidden = true
                //checkedButton.isHidden = false
                
                uncheckedButton.isHidden = UserDefaults.standard.bool(forKey: "SoundActive") ? true : false
                checkedButton.isHidden = UserDefaults.standard.bool(forKey: "SoundActive") ? false : true
            }
            
            else
            {
                //uncheckedButton.isHidden = false
                //checkedButton.isHidden = true
                
                uncheckedButton.isHidden = UserDefaults.standard.bool(forKey: "SoundActive") ? true : false
                checkedButton.isHidden = UserDefaults.standard.bool(forKey: "SoundActive") ? false : true
            }
        }
    }
    
    init(uncheckedButtonImage: String, checkedButtonImage: String, buttonAction: @escaping () -> Void)
    {
        uncheckedButton = SKSpriteNode(imageNamed: uncheckedButtonImage)
        checkedButton = SKSpriteNode(imageNamed: checkedButtonImage)
        uncheckedButton.isHidden = false
        checkedButton.isHidden = true
        action = buttonAction
        
        super.init()

        // This lets the Node respond to Input.
        isUserInteractionEnabled = true
        
        addChild(uncheckedButton)
        addChild(checkedButton)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        isChecked = !isChecked
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            let touchLocation = touch.location(in: parent!)
            
            if(self.contains(touchLocation))
            {
                
            }
            
            else
            {
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            let touchLocation = touch.location(in: parent!)
            
            if(self.contains(touchLocation))
            {
                action()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       
    }
}
