//
//  AlertItem.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    
    var alert: Alert { Alert(title: title, message: message, dismissButton: dismissButton) }
}

struct AlertContext {
    //MARK: - SearchView Errors
    static let invalidUsername = AlertItem(title: Text("Empty Username"),
                                           message: Text("Please enter a username, we need to know who to look for"),
                                           dismissButton: .default(Text("Ok")))
}
