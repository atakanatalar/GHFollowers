//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 18.07.2024.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month(.wide).year())
    }
}
