//
//  GFButton.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    var backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .background(backgroundColor)
            .foregroundColor(Color(.systemBackground))
            .cornerRadius(10)
    }
}

