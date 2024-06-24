//
//  Workout.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 23/06/24.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    var day: String
    var minutes: Double
}

extension Workout {
    static let walkWorkouts: [Workout] = [
        .init(day: "Jan", minutes: 23),
        .init(day: "Feb", minutes: 35),
        .init(day: "Mar", minutes: 55),
        .init(day: "Apr", minutes: 30),
        .init(day: "Jun", minutes: 15),
        .init(day: "Jul", minutes: 65),
        .init(day: "Sep", minutes: 81),
        .init(day: "Oct", minutes: 81),
        .init(day: "Nov", minutes: 81),
        .init(day: "Dec", minutes: 81)
    ]
    
    static let runWorkouts: [Workout] = [
        .init(day: "Jan", minutes: 16),
        .init(day: "Feb", minutes: 12),
        .init(day: "Mar", minutes: 33),
        .init(day: "Apr", minutes: 45),
        .init(day: "Jun", minutes: 22),
        .init(day: "Jul", minutes: 15),
        .init(day: "Sep", minutes: 90),
        .init(day: "Oct", minutes: 90),
        .init(day: "Nov", minutes: 90),
        .init(day: "Dec", minutes: 90)
    ]
    
    static let pollen: [Workout] = [
        .init(day: "Jan", minutes: 2),
        .init(day: "Feb", minutes: 38),
        .init(day: "Mar", minutes: 54),
        .init(day: "Apr", minutes: 23),
        .init(day: "Jun", minutes: 10),
        .init(day: "Jul", minutes: 56),
        .init(day: "Sep", minutes: 18),
        .init(day: "Oct", minutes: 18),
        .init(day: "Nov", minutes: 18),
        .init(day: "Dec", minutes: 18)
    ]
    
    static let pollution: [Workout] = [
        .init(day: "Jan", minutes: 61),
        .init(day: "Feb", minutes: 21),
        .init(day: "Mar", minutes: 33),
        .init(day: "Apr", minutes: 54),
        .init(day: "Jun", minutes: 11),
        .init(day: "Jul", minutes: 25),
        .init(day: "Sep", minutes: 70),
        .init(day: "Oct", minutes: 70),
        .init(day: "Nov", minutes: 70),
        .init(day: "Dec", minutes: 70)
    ]
}
