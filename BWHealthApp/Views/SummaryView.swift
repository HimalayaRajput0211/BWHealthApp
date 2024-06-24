//
//  SummaryView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 18/06/24.
//

import SwiftUI


struct SummaryView: View {
    @EnvironmentObject var manager: HealthManager

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: geometry.safeAreaInsets.top)
                        HStack {
                            Text("Summary")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                            Text("H R")
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                                .background(Color.blue.opacity(0.2))
                                .clipShape(Circle())
                            
                        }
                        
                        VStack(spacing: 20) {
                            ForEach(manager.activities) { item in
                                NavigationLink {
                                    SummaryDetailView(item: item)
                                } label: {
                                    SummaryActivityView(item: item)
                                }
                            }
                        }
                        
                        VStack {
                            NavigationLink {
                                HealthDataListView()
                            } label: {
                                HStack {
                                    Image(systemName: "heart.square")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .aspectRatio(contentMode: .fit)
                                        .tint(.red)
                                    Text("Show All Health Data")
                                        .font(.headline)
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10))

                        VStack {
                            NavigationLink {
                                WheatherGraphView()
                            } label: {
                                HStack {
                                    Image(systemName: "chart.xyaxis.line")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .aspectRatio(contentMode: .fit)
                                        .tint(.red)
                                    Text("Graphical Wheather Data")
                                        .font(.headline)
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                    
                }.ignoresSafeArea()
                    .background(
                        LinearGradient(colors: [.purple.opacity(0.5), .red.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                    )
            }
        }
    }
}

#Preview {
    SummaryView()
        .environmentObject(HealthManager())
}
