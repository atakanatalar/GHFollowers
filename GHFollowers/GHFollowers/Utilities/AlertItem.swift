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
    static let invalidUsername = AlertItem(title: AlertItemConstants.invalidUsernameTitle,
                                           message: AlertItemConstants.invalidUsernameMessage,
                                           dismissButton: .default(AlertItemConstants.dismissButtonTitle))
    
    static let defaultError = AlertItem(title: AlertItemConstants.defaultErrorTitle,
                                        message: AlertItemConstants.defaultErrorMessage,
                                        dismissButton: .default(AlertItemConstants.dismissButtonTitle))
    //MARK: - FollowersView
    static let addUserSuccess = AlertItem(title: AlertItemConstants.successTitle,
                                          message: AlertItemConstants.addUserSuccessMessage,
                                          dismissButton: .default(AlertItemConstants.dismissButtonTitle))
}
