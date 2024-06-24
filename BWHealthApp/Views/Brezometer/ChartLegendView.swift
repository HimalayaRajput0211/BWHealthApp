//
//  ChartLegendView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 24/06/24.
//

import SwiftUI

struct ChartLegendView: View {
    let color: Color
    let text: String

    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Rectangle().fill(color)
                .frame(width: 6, height: 6)
                .clipShape(RoundedRectangle(cornerRadius: 0.6))
            Text(text)
                .font(.caption)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    ChartLegendView(color: .green, text: "hey there")
}
