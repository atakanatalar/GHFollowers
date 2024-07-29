//
//  HapticManager.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 29.07.2024.
//

import SwiftUI

struct HapticManager {
    
    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
