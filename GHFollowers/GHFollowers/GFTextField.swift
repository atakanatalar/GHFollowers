//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .multilineTextAlignment(.center)
            .frame(height: 50)
            .overlay { RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray4), lineWidth: 2) }
    }
}
