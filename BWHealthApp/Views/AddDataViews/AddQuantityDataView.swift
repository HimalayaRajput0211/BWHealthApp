//
//  AddQuantityDataView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 21/06/24.
//

import SwiftUI

struct AddQuantityDataView: View {
    @EnvironmentObject var manager: HealthManager
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var selectedTime = Date()
    @State private var showTimePicker = false
    @State private var inputValue = ""
    @FocusState private var textFieldFocus: Bool
    @Binding var onButtonTap: Bool
    let item: HKDataItem

    var body: some View {
        List {
            VStack {
                HStack {
                    Text("Date")
                        .font(.title3)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(selectedDate.formattedDateWithMonthNameDatYear())
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            textFieldFocus = false
                            showDatePicker.toggle()
                        }
                }

                if showDatePicker {
                    DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                }
            }
            
            VStack {
                HStack {
                    Text("Time")
                        .font(.title3)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(selectedTime.formattedHourMinute())
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            textFieldFocus = false
                            showTimePicker.toggle()
                        }
                }

                if showTimePicker {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                }
            }
            
            HStack {
                Text(item.type.unit.capitalized)
                    .font(.title3)
                    .foregroundStyle(.gray)
                Spacer()
                TextField("", text: $inputValue)
                    .focused($textFieldFocus)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
        }.onAppear(perform: {
            textFieldFocus.toggle()
        })
        .onChange(of: onButtonTap, perform: { newValue in
            guard newValue else { return }
            updateHealthData()
        })
    }
}

extension AddQuantityDataView {
    func updateHealthData() {
        guard let doubleValue = Double(inputValue) else { return }
        let isSteps = item.type == .steps
        manager.saveQuantityHealthData(
            type: isSteps ? .init(.stepCount) : .init(.activeEnergyBurned),
            quantity: .init(unit: isSteps ? .count() : .kilocalorie(), doubleValue: doubleValue),
            startDate: selectedDate.addTimeComponents(from: selectedTime)
        ) {
            DispatchQueue.main.async {
                onButtonTap = false
                dismiss()
            }
        }
    }
}

#Preview {
    AddQuantityDataView(onButtonTap: .constant(false), item: HKDataItem(type: .steps, time: "12: 00 PM", value: "172"))
}
