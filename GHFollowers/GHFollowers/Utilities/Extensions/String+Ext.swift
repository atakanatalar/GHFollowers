//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 29.07.2024.
//

import Foundation

extension String {
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
