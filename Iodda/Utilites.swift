//
//  Utilites.swift
//  Iodda
//
//  Created by Vlad on 2/7/25.
//

import Foundation

public func formattedCurrency(amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    formatter.maximumFractionDigits = amount.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
    return formatter.string(from: NSNumber(value: amount)) ?? "\(amount) €"
}

public let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
