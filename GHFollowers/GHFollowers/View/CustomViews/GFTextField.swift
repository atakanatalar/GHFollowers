//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
    @Binding var text: String
    let dynamicTypeSize: DynamicTypeSize
    
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
                .font(.title2)
                .multilineTextAlignment(.leading)
                .submitLabel(.go)
                .padding(.leading, 8)
                .padding(.trailing, dynamicTypeSize >= .accessibility1 ? 48 : 38)
                .frame(height: dynamicTypeSize >= .accessibility1 ? 72 : 48)
                .overlay { RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray4), lineWidth: 2) }
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: GFTextFieldConstants.clearButtonImageTitle)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.secondary)
                        .frame(width: dynamicTypeSize >= .accessibility1 ? 30 : 20, height: dynamicTypeSize >= .accessibility1 ? 30 : 20)
                }
                .padding(.horizontal, 8)
                .frame(height: dynamicTypeSize >= .accessibility1 ? 72 : 48)
            }
        }
    }
}
