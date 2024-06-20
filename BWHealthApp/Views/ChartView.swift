//
//  ChartView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import SwiftUI
import Charts

struct DailyStepView: Identifiable {
    let id = UUID()
    let date: Date
    let stepCount: Double
}

enum ChartOptions {
    case daily
    case oneWeek
    case oneMonth
    case sixMonths
    case oneYear
    
    func getAverageValue(totalCount: Double, maximumFractionDigits: Int) -> String {
        var value: Double {
            switch self {
            case .daily:
                return totalCount
            case .oneWeek:
                return (totalCount / Double(7))
            case .oneMonth:
                return (totalCount / Double(30))
            case .sixMonths:
                return (totalCount / Double(4*6))
            case .oneYear:
                return (totalCount / Double(12))
            }
        }

        return value.formattedString(maximumFractionDigits: maximumFractionDigits)
    }
    
    var startDate: Date {
        switch self {
        case .daily:
            return .startOfDay
        case .oneWeek:
            return .oneWeakAgo
        case .oneMonth:
            return .oneMonthAgo
        case .sixMonths:
            return .sixMonthsAgo
        case .oneYear:
            return .oneYearAgo
        }
    }
    
    var interval: DateComponents {
        switch self {
        case .daily:
            return DateComponents(hour: 1)
        case .oneWeek, .oneMonth:
            return DateComponents(day: 1)
        case .sixMonths:
            return DateComponents(day: 7)
        case .oneYear:
            return DateComponents(month: 1)
        }
    }
    
    func getBarMark(daily: DailyStepView) ->  BarMark {
        switch self {
        case .daily:
            return  BarMark(x: .value("", daily.date, unit: .hour),
                            y: .value("Steps", daily.stepCount))
        case .oneWeek:
            return  BarMark(x: .value("", daily.date.getWeekDay()),
                            y: .value("Steps", daily.stepCount))
        case .oneMonth:
            return BarMark(x: .value("", daily.date, unit: .day),
                           y: .value("Steps", daily.stepCount))
        case .sixMonths:
            return  BarMark(x: .value("", daily.date, unit: .weekOfMonth),
                            y: .value("Steps", daily.stepCount))
        case .oneYear:
            return  BarMark(x: .value("", daily.date.getFirstMonthCharacter()),
                            y: .value("Steps", daily.stepCount))
        }
    }
}

struct ChartView: View {
    @EnvironmentObject var manager: HealthManager
    let item: HKDataItem
    @State private var selectedChartOption: ChartOptions = .daily
    private var totalCount: Double {
        manager.oneMonthChartData.reduce(into: 0.0) { array, listItem in
            array += listItem.stepCount
        }
    }
    private var displayAverage: String {
        selectedChartOption.getAverageValue(
            totalCount: totalCount, maximumFractionDigits: item.type == .steps ? 0 : 1
        )
    }
    private var displayDate: String {
        guard selectedChartOption == .daily else {
            return selectedChartOption.startDate.formattedDateWithMonthNameDatYear() + "-" + Date().formattedDateWithMonthNameDatYear()
        }

        return "Today"
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                Picker("picker", selection: $selectedChartOption) {
                    Text("D").tag(ChartOptions.daily)
                    Text("W").tag(ChartOptions.oneWeek)
                    Text("M").tag(ChartOptions.oneMonth)
                    Text("6M").tag(ChartOptions.sixMonths)
                    Text("Y").tag(ChartOptions.oneYear)
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedChartOption, perform: { _ in
                    fetchChartData()
                })
                VStack(alignment: .leading) {
                    Text("Average".uppercased())
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Text("\(displayAverage) ").font(.title).foregroundColor(.black) + Text(item.type.unit).font(.subheadline).foregroundColor(.gray)
                    Text(displayDate)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                }
                
                Chart {
                    ForEach(manager.oneMonthChartData) { daily in
                        selectedChartOption.getBarMark(daily: daily)
                    }
                }
                .padding()
                .frame(maxHeight: .infinity)
                .foregroundStyle(.orange)
                .border(Color.gray)
            }
        }
        .onAppear(perform: {
            fetchChartData()
        })
    }
    
    private func fetchChartData() {
        switch selectedChartOption {
        case .daily, .oneWeek, .oneMonth:
            manager.fetchDailyChartData(type: item.type, startDate: selectedChartOption.startDate,
                                        interval: selectedChartOption.interval)
        case .sixMonths, .oneYear:
            manager.fetchAverageChartData(type: item.type, startDate: selectedChartOption.startDate, 
                                          interval: selectedChartOption.interval)
        }
    }
}

#Preview {
    ChartView(item: HKDataItem(type: .height, time: "12: 00 PM", value: "172"))
        .environmentObject(HealthManager())
}
