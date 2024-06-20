//
//  HealthDataListView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import SwiftUI

struct HealthDataListView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(Date.startOfDay.formatted())
            Text(Date.startOfWeek.formatted())
            Text(Date().startOfMonth().formatted())
            Text(Date.oneDayAgo.formatted())
            Text(Date.oneWeakAgo.formatted())
            Text(Date.oneMonthAgo.formatted())
            Text(Date.sixMonthsAgo.formatted())
            Text(Date.oneYearAgo.formatted())
        }
    }
}

#Preview {
    HealthDataListView()
}
