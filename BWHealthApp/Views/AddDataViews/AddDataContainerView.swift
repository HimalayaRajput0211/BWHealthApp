//
//  AddDataContainerView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 21/06/24.
//

import SwiftUI

struct AddDataContainerView: View {
    @Environment(\.dismiss) var dismiss
    let item: HKDataItem
    @State private var onButtonTap = false

    private var isWorkout: Bool {
        item.type == .steps || item.type == .calories ? false : true
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometryReader in
                VStack {
                    if isWorkout {
                        AddWorkoutDataView(item: item, onButtonTap: $onButtonTap)
                    } else {
                        AddQuantityDataView(onButtonTap: $onButtonTap, item: item)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            onButtonTap.toggle()
                        }, label: {
                            Text("Add")
                        })
                        .disabled(onButtonTap)
                    }
                }
                .navigationTitle(isWorkout ? "Workout" : item.type.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    AddDataContainerView(item: HKDataItem(type: .steps, time: "12: 00 PM", value: "172"))
}
