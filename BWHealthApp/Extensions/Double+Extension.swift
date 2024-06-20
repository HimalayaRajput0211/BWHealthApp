//
//  Double+Extension.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import Foundation

extension Double {
    var toString: String {
        return "\(self)"
    }

    func formattedString(maximumFractionDigits: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
