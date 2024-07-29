//
//  Device.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 29.07.2024.
//

import UIKit

class Device {
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    static func isSmallScreen() -> Bool {
        return screenHeight <= 812
    }
}

//MARK: - iPhone SE 3rd gen, SE 2nd gen, 8, 7 -> 667.0
//MARK: - iPhone 13 Mini, 12 Mini, 11 Pro, XS, X -> 812.0
