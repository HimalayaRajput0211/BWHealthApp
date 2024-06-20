//
//  BWHealthAppApp.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 18/06/24.
//

import SwiftUI

@main
struct BWHealthAppApp: App {
    @StateObject var manager = HealthManager()

    var body: some Scene {
        WindowGroup {
            BWTabView()
                .environmentObject(manager)
        }
    }
}
