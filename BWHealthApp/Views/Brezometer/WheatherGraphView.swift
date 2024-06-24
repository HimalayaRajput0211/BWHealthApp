//
//  WheatherGraphView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 23/06/24.
//

import SwiftUI
import Charts


struct WheatherGraphView: View {
    let workouts = [
        (workoutType: "UV", color: Color(hex: "#F8CD51"), data: Workout.walkWorkouts),
        (workoutType: "WildFire Smoke", color: Color(hex: "#6C6FB4"), data: Workout.runWorkouts),
        (workoutType: "Pollen", color: Color(hex: "#1F2148"), data: Workout.pollen),
        (workoutType: "Pollution", color: Color(hex: "#AAACD5"), data: Workout.pollution)
    ]
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading, spacing: 16) {
                Text("2/ 10")
                    .font(.title)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                Text("Your 2023 Skin score".uppercased())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Chart {
                    ForEach(workouts, id: \.workoutType) { series in
                        ForEach(series.data) { element in
                            LineMark(x: .value("Day", element.day), y: .value("Mins", element.minutes))
                                .interpolationMethod(.linear)
                        }
                        .lineStyle(StrokeStyle(lineWidth: 1.5))
                        .foregroundStyle(by: .value("WorkoutType", series.workoutType))
                    }
                }
                .customAxis()
                .frame(height: 150)
                .padding(.top, 16)
                .chartYScale(domain: 0...90)
                // Set color for each data in the chart
                .chartForegroundStyleScale(range: workouts.map { $0.color })

                // this changes the position of the chart info
                .chartLegend(position: .bottom, alignment: .leadingLastTextBaseline, content: {
                    HStack(spacing: 16) {
                        ForEach(workouts,  id: \.workoutType) { workout in
                            ChartLegendView(color: workout.color, text: workout.workoutType)
                        }
                    }.padding(.horizontal, 16)
                })
                Text("Better than 42% of people in your area")
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    
            }
            .padding()
            .background(Color(red: 71/256, green: 75/256, blue: 161/255), in: RoundedRectangle(cornerRadius: 20))
        }
        .padding()
    }
}

#Preview {
    WheatherGraphView()
}
