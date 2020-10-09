// Sound.swift
// CharacterAnimation
import SpriteKit
import AVFoundation

// Audio player that uses AVFoundation to play looping
// background music and short sound effects. This is for
// when using SKActions just is not good enough.
class SKTAudio
{
    public var musicPlayer: AVAudioPlayer?
    public var soundEffectPlayer: AVAudioPlayer?
    public var error: NSError? = nil
    
    public class func sharedInstance() -> SKTAudio
    {
        return SKTAudioInstance
    }
    
    public func playMusic(filename: String)
    {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        
        if (url == nil)
        {
            print("Could not find file: \(filename)")
            return
        }
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url!)
        }
            
        catch let error as NSError
        {
            NSLog("Error playing music: %@", error)
            musicPlayer = nil
        }
        
        if let player = musicPlayer
        {
            player.numberOfLoops = -1
            player.volume = 0.25
            player.prepareToPlay()
            player.play()
        }
            
        else
        {
            print("Could not create Audio Player: \(error!)")
        }
    }
    
    public func pauseMusic()
    {
        if let player = musicPlayer
        {
            if (player.isPlaying)
            {
                player.pause()
            }
        }
    }
    
    public func resumeMusic()
    {
        if let player = musicPlayer {
            if (!player.isPlaying)
            {
                player.play()
            }
        }
    }
    
    public func playSoundEffect(filename: String)
    {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        
        if (url == nil)
        {
            print("Could not find file: \(filename)")
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url!)
        }
        
        catch let error as NSError
        {
            NSLog("Error playing music: %@", error)
            soundEffectPlayer = nil
        }
        
        if let player = soundEffectPlayer
        {
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        }
            
        else
        {
            print("Could not create Audio Player: \(error!)")
        }
    }
}

private let SKTAudioInstance = SKTAudio()
