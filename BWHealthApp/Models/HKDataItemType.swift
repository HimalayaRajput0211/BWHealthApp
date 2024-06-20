//
//  HKDataItemType.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import Foundation
import SwiftUI

enum HKDataItemType: String {
    case height
    case sleep
    case steps
    case calories
    case running
    case strength
    case soccer
    case stairClimbing
    case cycling
    case football
    

    var title: String {
        switch self {
        case .height:
            return "Height"
        case .sleep:
            return "Sleep"
        case .steps:
            return "Steps"
        case .calories:
            return "Active Energy"
        case .running:
            return "Running"
        case .strength:
            return "Weight Lifting"
        case .soccer:
            return "Soccer"
        case .stairClimbing:
            return "Stair Stepper"
        case .cycling:
            return "Cycling"
        case .football:
            return "Football"
        }
    }

    var icon: String {
        switch self {
        case .height:
            return "figure"
        case .sleep:
            return "bed.double.fill"
        case .calories, .steps, .running:
            return "flame.fill"
        case .strength:
            return "dumbbell"
        case .soccer:
            return "figure.soccer"
        case .stairClimbing:
            return "figure.stair.stepper"
        case .cycling:
            return "figure.hand.cycling"
        case .football:
            return "figure.american.football"
        }
    }

    var themeColor: Color {
        switch self {
        case .height:
            return .purple
        case .sleep:
            return  .green
        case .steps, .calories, .running, .stairClimbing:
            return .orange
        case .cycling, .strength, .soccer:
            return .cyan
        case .football:
            return .blue
        }
    }
    
    var unit: String {
        switch self {
        case .height:
            return "cm"
        case .sleep:
            return ""
        case .steps:
            return "steps"
        case .calories:
            return "kcal"
        case .running, .stairClimbing, .cycling, .football, .strength, .soccer:
            return "minutes"
        }
    }
}
