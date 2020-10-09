// LabelEntity.swift
// CharacterAnimation
import SpriteKit
import GameplayKit

import SpriteKit
import GameplayKit

class LabelEntity: GKEntity
{
    var labelComponent: LabelComponent!
    
    init(fontName: String)
    {
        super.init()
        
        labelComponent = LabelComponent(entity: self, fontName: fontName)
        addComponent(labelComponent)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
