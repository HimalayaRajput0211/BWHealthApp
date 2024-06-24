//
//  HKWorkoutActivityType+Extension.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 21/06/24.
//

import Foundation
import HealthKit

extension HKWorkoutActivityType {
    var displayValue: String {
        switch self {
        case .running:
            return "Running"
        case .traditionalStrengthTraining:
            return "Traditional Strength Training"
        case .americanFootball:
            return "American Football"
        case .soccer:
            return "Soccer"
        case .cycling:
            return "Cycling"
        case .stairClimbing:
            return "Stair Climbing"
        default:
            return ""
        }
    }
}
