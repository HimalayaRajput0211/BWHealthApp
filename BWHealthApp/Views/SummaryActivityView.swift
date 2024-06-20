//
//  SummaryActivityView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import SwiftUI

struct SummaryActivityView: View {
    let item: HKDataItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: item.type.icon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(item.type.themeColor)
                Text(item.type.title)
                    .font(.headline)
                    .foregroundStyle(item.type.themeColor)
                Spacer()
                Text(item.time)
                    .font(.caption)
                    .foregroundStyle(.gray)
                Image(systemName: "chevron.forward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .tint(.gray)
            }
            if item.value.isEmpty {
                Text("No Data")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
            } else {
                Text(item.value).font(.title).foregroundColor(.black) +
                Text("  \(item.type.unit)")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SummaryActivityView(item: HKDataItem(type: .height, time: "12: 00 PM", value: "172"))
}
