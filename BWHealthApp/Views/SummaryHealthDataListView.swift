//
//  SummaryHealthDataListView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import SwiftUI

struct ListItem: Hashable {
    let value: String
    let date: String
}

extension ListItem: Identifiable {
    var id: String { UUID().uuidString }
}

struct SummaryHealthDataListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var manager: HealthManager
    let item: HKDataItem

    var body: some View {
        List {
            Section(item.type.unit) {
                ForEach(manager.listItems) { item in
                    NavigationLink {
                        HealthDataDetailView()
                    } label: {
                        HStack {
                            Text(item.value)
                            Spacer()
                            Text(item.date)
                        }
                    }
                    
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .tint(.blue)
                    Text(item.type.title)
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Text("Add Data")
                })
            }
        }
        .navigationTitle("All Recorded Data")
        .navigationBarBackButtonHidden()
        .onAppear {
            manager.resetListItems()
            manager.fetchAllStepsData(type: item.type)
        }
    }
}

#Preview {
    SummaryHealthDataListView(item: HKDataItem(type: .height, time: "12: 00 PM", value: "172"))
}
