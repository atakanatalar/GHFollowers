//
//  ContentView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashViewPresented: Bool = false
    
    var body: some View {
        if isSplashViewPresented {
            AppTabView()
        } else {
            SplashView(isPresented: $isSplashViewPresented)
        }
    }
}

#Preview {
    ContentView()
}
