// ShadowedLabelNode.swift
// CharacterAnimation
import SpriteKit

class ShadowedLabelNode: SKNode
{
    private let label: SKLabelNode
    private let shadowLabel: SKLabelNode
    
    var text: String {
        get {
            return label.text!
        }
        
        set {
            label.text = newValue
            shadowLabel.text = newValue
        }
    }
    
    var verticalAlignmentMode: SKLabelVerticalAlignmentMode {
        get {
            return label.verticalAlignmentMode
        }
        
        set {
            label.verticalAlignmentMode = newValue
            shadowLabel.verticalAlignmentMode = newValue
        }
    }
    
    var horizontalAlignmentNode: SKLabelHorizontalAlignmentMode {
        get {
            return label.horizontalAlignmentMode
        }
        
        set {
            label.horizontalAlignmentMode = newValue
            shadowLabel.horizontalAlignmentMode = newValue
        }
    }
    
    var size: CGSize {
        return calculateAccumulatedFrame().size
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontName: String, fontSize size: CGFloat, color: SKColor, shadowColor: SKColor)
    {
        label = SKLabelNode(fontNamed: fontName)
        label.fontSize = size
        label.fontColor = color
        
        shadowLabel = SKLabelNode(fontNamed: fontName)
        shadowLabel.fontSize = size
        shadowLabel.fontColor = shadowColor
        
        super.init()
        
        shadowLabel.position = CGPoint(x: 1, y: -1)
        addChild(label)
        addChild(shadowLabel)
    }
}
