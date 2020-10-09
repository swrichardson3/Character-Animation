// Dictionary+Extensions.swift
// CharacterAnimation
import Foundation

extension Dictionary
{
    // Loads a JSON file from the App Bundle into a new Dictionary.
    static func loadJSONFromBundle(filename: String) -> Dictionary<String, AnyObject>?
    {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        
        do {
            if let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Dictionary<String, AnyObject> {
                return dataAsJSON
            }
            
            else
            {
                return nil
            }
        }
        
        catch
        {
            print(error.localizedDescription)
            return nil
        }
    }
}
