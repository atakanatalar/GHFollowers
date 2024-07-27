//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
    let dynamicTypeSize: DynamicTypeSize
    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .multilineTextAlignment(.center)
            .submitLabel(.go)
            .frame(height: dynamicTypeSize >= .accessibility1 ? 72 : 48)
            .overlay { RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray4), lineWidth: 2) }
    }
}
