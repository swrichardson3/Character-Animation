// LevelMap.swift
// CharacterAnimation
import Foundation
import SpriteKit

class Troll
{
    var trollName: String
    var walkSpeed: Int
    var runSpeed: Int
    
    init(trollName: String, walkSpeed: Int, runSpeed: Int)
    {
        self.trollName = trollName
        self.walkSpeed = walkSpeed
        self.runSpeed = runSpeed
    }
}

class LevelMap
{
    var trolls = [String: Troll]()
    var error: NSError? = nil
    
    public class func sharedInstance() -> LevelMap
    {
        return LevelMapInstance
    }
    
    // Create a Level by loading it from a JSON File.
    func loadJSON(filename: String)
    {
        if let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) {
            
            if let levelsArray = dictionary["trolls"] as? Array<Dictionary<String, AnyObject>> {
                for(index, dict) in levelsArray.enumerated()
                {
                    let trollName = dict["name"] as? String ?? "Troll\(index + 1)"
                    let walkSpeed = dict["walkSpeed"] as? Int ?? 0
                    let runSpeed = dict["runSpeed"] as? Int ?? 0
                    
                    let troll = Troll(trollName: trollName, walkSpeed: walkSpeed, runSpeed: runSpeed)
                    trolls[trollName] = troll
                }
            }
        }
            
        else
        {
            print("Could not load JSON File")
        }
    }
}

private let LevelMapInstance = LevelMap()

