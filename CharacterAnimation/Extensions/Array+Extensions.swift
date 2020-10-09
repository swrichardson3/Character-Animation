// Array+Extensions.swift
// CharacterAnimation
import Foundation
import SpriteKit

extension Array
{
    mutating func shuffle()
    {
        if(count < 2)
        {
            return
        }
        
        for i in 0..<(count - 1)
        {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            
            if(i != j)
            {
                self.swapAt(i, j)
            }
        }
    }
}
