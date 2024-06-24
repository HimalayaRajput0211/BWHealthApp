//
//  WorkoutDataItem.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 21/06/24.
//

import Foundation
import HealthKit

struct WorkoutDataItem: Hashable {
    let type: HKDataItemType
    let showEnergyBurnedField: Bool
    let showDistanceField: Bool

    static var all: [WorkoutDataItem] {
        return [
            WorkoutDataItem(type: .running, showEnergyBurnedField: true, showDistanceField: true),
            WorkoutDataItem(type: .strength, showEnergyBurnedField: true, showDistanceField: false),
            WorkoutDataItem(type: .cycling, showEnergyBurnedField: true, showDistanceField: true),
            WorkoutDataItem(type: .football, showEnergyBurnedField: true, showDistanceField: true),
            WorkoutDataItem(type: .soccer, showEnergyBurnedField: true, showDistanceField: true),
            WorkoutDataItem(type: .stairClimbing, showEnergyBurnedField: true, showDistanceField: true)
        ]
    }
}

extension WorkoutDataItem: Identifiable {
    var id: String {
        return UUID().uuidString
    }
}
