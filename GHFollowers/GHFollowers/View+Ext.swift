//
//  View+Ext.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 14.07.2024.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
