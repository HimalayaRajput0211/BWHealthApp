//
//  ChartAxisModifier.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 24/06/24.
//

import SwiftUI
import Charts

struct ChartAxisModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .chartXAxis(content: {
                AxisMarks(preset: .aligned) { value in
                    if let text = value.as(String.self) {
                        AxisValueLabel(orientation: .horizontal, horizontalSpacing: 0, verticalSpacing: 10) {
                            VStack {
                                Divider().background(Color.white)
                                Text(text)
                                Spacer().frame(height: 12)
                            }
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(Color(hex: "#6C6FB4").opacity(0.5))
                            .offset(x: 0, y: 0)
                    }
                }
            })
            .chartYAxis(content: {
                AxisMarks(position: .leading, values: .stride(by: 30)) {
                    AxisValueLabel()
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
            })
    }
}
