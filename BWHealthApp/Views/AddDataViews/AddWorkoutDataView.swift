//
//  AddWorkoutDataView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 21/06/24.
//

import SwiftUI
import HealthKit

struct AddWorkoutDataView: View {
    @EnvironmentObject var manager: HealthManager
    @Environment(\.dismiss) var dismiss
    private let workouts = WorkoutDataItem.all
    private let item: HKDataItem
    @State private var selectedWorkout: WorkoutDataItem
    @State private var showActivityPicker = false
    @State private var startDate = Date()
    @State private var showStartDate = false
    @State private var endDate = Date()
    @State private var showEndDate = false
    @State private var kcalFieldInput = ""
    @FocusState private var kcalFieldFocus: Bool
    @State private var distanceFieldInput = ""
    @FocusState private var distanceFieldFocus: Bool
    @Binding private var onButtonTap: Bool

    init(item: HKDataItem, onButtonTap: Binding<Bool>) {
        self.item = item
        self._onButtonTap = onButtonTap
        self.selectedWorkout = workouts.first(where: { $0.type == item.type }) ?? workouts[0]
    }

    var body: some View {
        List {
            Section {
                VStack {
                    HStack {
                        Text("Activity Type")
                            .font(.title3)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text(selectedWorkout.type.activityType.displayValue)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                distanceFieldFocus = false
                                kcalFieldFocus = false
                                showActivityPicker.toggle()
                            }
                    }

                    if showActivityPicker {
                        Picker("Please choose a activity type", selection: $selectedWorkout) {
                            ForEach(workouts) { workout in
                                Text(workout.type.activityType.displayValue).tag(workout as WorkoutDataItem)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                    
                VStack {
                    if selectedWorkout.showEnergyBurnedField {
                        HStack {
                            Text("Kilocalories")
                                .font(.title3)
                                .foregroundStyle(.gray)
                            Spacer()
                            TextField("", text: $kcalFieldInput)
                                .focused($kcalFieldFocus)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                    }
                }
   
                VStack {
                    if selectedWorkout.showDistanceField {
                        HStack {
                            Text("Distance (km)")
                                .font(.title3)
                                .foregroundStyle(.gray)
                            Spacer()
                            TextField("", text: $distanceFieldInput)
                                .focused($distanceFieldFocus)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                    }
                }
            }
            
            Section {
                VStack {
                    HStack {
                        Text("Starts")
                            .font(.title3)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text(startDate.formattedDateAndtime())
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                distanceFieldFocus = false
                                kcalFieldFocus = false
                                showStartDate.toggle()
                            }
                    }

                    if showStartDate {
                        DatePicker("", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.wheel)
                    }
                }

                VStack {
                    HStack {
                        Text("Ends")
                            .font(.title3)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text(endDate.formattedDateAndtime())
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                distanceFieldFocus = false
                                kcalFieldFocus = false
                                showEndDate.toggle()
                            }
                    }

                    if showEndDate {
                        DatePicker("", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.wheel)
                    }
                }
            }
        }
        .onChange(of: onButtonTap, perform: { newValue in
            guard newValue else { return }
            updateHealthData()
        })
    }
}

extension AddWorkoutDataView {
    func updateHealthData() {
        var energyBurned: HKQuantity?
        var distance: HKQuantity?
        if let value = Double(kcalFieldInput) {
            energyBurned = HKQuantity(unit: .kilocalorie(), doubleValue: value)
        }
        if let value = Double(distanceFieldInput) {
            distance = HKQuantity(unit: .meter(), doubleValue: value * 1000)
        }
        manager.saveWorkoutHealthData(
            activityType: item.type.activityType,
            startDate: startDate,
            endDate: endDate,
            energyBurned: energyBurned,
            distance: distance) {
                DispatchQueue.main.async {
                    onButtonTap = false
                    dismiss()
                }
            }
    }
}

#Preview {
    AddWorkoutDataView(item: HKDataItem(type: .running, time: "12: 00 PM", value: "172"), onButtonTap: .constant(false))
}
