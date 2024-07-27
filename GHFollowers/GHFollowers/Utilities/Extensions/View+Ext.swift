//
//  View+Ext.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 27.07.2024.
//

import SwiftUI

extension View {
    func embedInScrollView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                self.frame(minHeight: geometry.size.height, maxHeight: .infinity)
            }
        }
    }
}
