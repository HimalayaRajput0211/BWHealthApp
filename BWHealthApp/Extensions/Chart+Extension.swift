//
//  Chart+Extension.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 24/06/24.
//

import Charts
import SwiftUI

extension Chart {
    func customAxis() -> some View {
        self.modifier(ChartAxisModifier())
    }
}
