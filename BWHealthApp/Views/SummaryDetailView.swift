//
//  SummaryDetailView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import SwiftUI

struct SummaryDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let item: HKDataItem

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    ChartView(item: item)
                        .environmentObject(HealthManager())
                        .padding()
                        .frame(height: 550)
                        .background(Color.white)
                    
                    Text("Options")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    NavigationLink {
                        SummaryHealthDataListView(item: item)
                    } label: {
                        HStack {
                            Text("Show All Data")
                                .font(.headline)
                                .foregroundStyle(.gray)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .tint(.gray)
                        }
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(
                            .white,
                            in: RoundedRectangle(cornerRadius: 10)
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                    
                }
            }
            .background(Color.gray.opacity(0.2))
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
                        Text("Summary")
                    })
                }
            }
        }
        .navigationTitle(item.type.title)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SummaryDetailView(item: HKDataItem(type: .height, time: "12: 00 PM", value: "172"))
}
