// Colors.swift
// CharacterAnimation
import SpriteKit

class Colors
{
    class var score: Int { return 0xE9FC00 }
    class var time: Int  { return 0xE9FC00 }
    class var flash: Int { return 0x000000 }
    
    class func colorFrom(rgb: Int) -> SKColor
    {
        return SKColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgb & 0x0000FF) / 255.0,
                       alpha: 1.0)
    }
}
