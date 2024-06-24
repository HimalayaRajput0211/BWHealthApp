//
//  MapView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 24/06/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(coordinateRegion: .constant(.init()))
            .frame(height: 200)
    }
}

#Preview {
    MapView()
}
