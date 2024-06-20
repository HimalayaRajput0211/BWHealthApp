//
//  BWTabView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 18/06/24.
//

import SwiftUI

struct BWTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            SummaryView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Summary")
                }.tag(0)
            SharingView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Sharing")
                }.tag(1)
            BrowseView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Browse")
                }.tag(2)
        }
    }
}

#Preview {
    BWTabView()
}
