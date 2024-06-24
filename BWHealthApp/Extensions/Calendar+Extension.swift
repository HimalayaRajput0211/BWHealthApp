//
//  Calendar+Extension.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 21/06/24.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int? {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day
    }
}
