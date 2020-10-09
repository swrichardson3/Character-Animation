// UserDefaults+Extension.swift
// CharacterAnimation
import Foundation

extension UserDefaults
{
    // We make the function static because we
    // are accessing a singleton standard.
    static func contains(key: String) -> Bool
    {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
