// SoundManager.swift
import Foundation
import SpriteKit

class SoundManager
{
    let buttonAudioAction = SKAction.playSoundFileNamed("Button.caf", waitForCompletion: false)
    
    static let sharedInstance = SoundManager()
}
