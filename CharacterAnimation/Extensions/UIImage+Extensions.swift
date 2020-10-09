// UserDefaults+Extension.swift
// CharacterAnimation
import UIKit
import SpriteKit

extension UIImage
{
    func resized(to size: CGSize) -> UIImage
    {
        return UIGraphicsImageRenderer(size: size).image(actions: { _ in
            draw(in: CGRect(origin: .zero, size: size))
        })
    }
}
