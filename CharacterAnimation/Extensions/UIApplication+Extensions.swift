// UIApplication+Extensions.swift
// CharacterAnimation
import Foundation
import SpriteKit

extension UIApplication
{
    static var hasToNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *)
        {
            // With notch: 44.0 on iPhone X, XS, XS Max, XR.
            // Without notch: 24.0 on iPad Pro 12.9" 3rd generation, 20.0 on iPhone 8 on iOS 12+.
            return shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
        }
        
        return false
    }
    
    static var hasBottomSafeAreaInsets: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // With home indicator: 34.0 on iPhone X, XS, XS Max, XR.
            // With home indicator: 20.0 on iPad Pro 12.9" 3rd generation.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 0
        }
        
        return false
    }
}
