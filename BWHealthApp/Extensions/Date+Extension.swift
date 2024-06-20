//
//  Date+Extension.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import Foundation
import UIKit
import SwiftUI

extension Date {
    static var startOfDay: Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date {
        let calender = Calendar.current
        var components = calender.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2
        return calender.date(from: components) ?? Date()
    }

    static var oneDayAgo: Date {
        let calendar = Calendar.current
        guard let oneDay = calendar.date(byAdding: .day, value: -1, to: Date())
        else { return Date() }
        return calendar.startOfDay(for: oneDay)
    }

    static var oneMonthAgo: Date {
        let calendar = Calendar.current
        guard let oneMonth = calendar.date(byAdding: .month, value: -1, to: Date())
        else { return Date() }
        return calendar.startOfDay(for: oneMonth)
    }

    static var sixMonthsAgo: Date {
        let calendar = Calendar.current
        let componets = DateComponents(month: -6)
        guard let sixMonth = calendar.date(byAdding: componets, to: Date())
        else { return Date() }
        return calendar.startOfDay(for: sixMonth.startOfMonth())
    }

    static var oneYearAgo: Date {
        let calendar = Calendar.current
        guard let oneYear = calendar.date(byAdding: .year, value: -1, to: calendar.startOfDay(for: Date()))
        else { return Date() }
        return calendar.startOfDay(for: oneYear.startOfMonth())
    }

    static var oneWeakAgo: Date {
        let calendar = Calendar.current
        guard let oneWeek = calendar.date(byAdding: .day, value: -6, to: Date())
        else { return Date() }
        return calendar.startOfDay(for: oneWeek)
    }

    static var calendarInitialDate: Date {
        let calendar = Calendar.current
        let components = DateComponents(calendar: calendar, timeZone: calendar.timeZone)
        return calendar.date(from: components) ?? Date()
    }
}

extension Date {
    func startOfMonth() -> Date {
        let calender = Calendar.current
        var components = calender.dateComponents([.year, .month], from: self)
        components.hour = 0
        let date = calender.date(from: components) ?? self
        return calender.startOfDay(for: date)
    }
}

extension Date {
    func formattedDateWithDayMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }

    func formattedDateWithMonthNameDatYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd"
        return formatter.string(from: self)
    }

    func getWeekDay()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let weekDay = dateFormatter.string(from: self)
        return weekDay
    }
    
    func getShortMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let weekDay = dateFormatter.string(from: self)
        return weekDay
    }

    func getFirstMonthCharacter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let weekDay = dateFormatter.string(from: self)
        return weekDay.prefix(1).uppercased()
    }
    
    func getDay()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let weekDay = dateFormatter.string(from: self)
        return weekDay
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int? {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day
    }
}
