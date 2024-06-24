//
//  GroupBoxStyleView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 23/06/24.
//

import SwiftUI

struct GroupBoxStyleHelper: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top, 30)
            .padding(20)
            .background(Color(red: 71/256, green: 75/256, blue: 161/255))
            .cornerRadius(20)
            .overlay(
                configuration.label.padding(16),
                alignment: .topLeading
            )
    }
}
