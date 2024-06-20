//
//  HealthManager.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import Foundation
import HealthKit


final class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    @Published private(set) var activities = [HKDataItem]()
    @Published private(set) var oneMonthChartData = [DailyStepView]()
    @Published private(set) var listItems = [ListItem]()
    
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let workout = HKSampleType.workoutType()
        
        let healthTypes: Set = [steps, calories, workout]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaysSteps()
                fetchTodaysCalories()
                fetchWeekRunningStats()
            } catch {
                print("error fetching health data")
            }
        }
    }
}

extension HealthManager {
    func resetListItems() {
        listItems = []
    }
}

extension HealthManager {
    private func fetchTodaysSteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let unwrappedResults = results,
                  let quantity = unwrappedResults.sumQuantity(),
                    error == nil  else {
                print("error fetching total steps data")
                return
            }
            
            let stepCount = Double(quantity.doubleValue(for: .count()))
            DispatchQueue.main.async { [weak self] in
                self?.activities.append(
                    HKDataItem(type: .steps, time: unwrappedResults.startDate.formattedDate(),
                               value: stepCount.formattedString(maximumFractionDigits: 0))
                )
            }
        }

        healthStore.execute(query)
    }
    
    private func fetchTodaysCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        print(Date.startOfDay)
        print(Date.startOfDay.formatted())
        print(Date.startOfDay.ISO8601Format())
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, results, error in
            guard let unwrappedResults = results,
                  let quantity = unwrappedResults.sumQuantity(),
                    error == nil  else {
                print("error fetching total calories data")
                return
            }
            
            print("*****")
            print(unwrappedResults.startDate)
            print("*****")
            print(unwrappedResults.startDate.formatted())
            print("*****")
            print(unwrappedResults.startDate.ISO8601Format())
            print("*****")
            
            let caloriesBurned = Double(quantity.doubleValue(for: .kilocalorie()))
            DispatchQueue.main.async { [weak self] in
                self?.activities.append(
                    HKDataItem(type: .calories, time: unwrappedResults.startDate.formattedDate(),
                               value: caloriesBurned.formattedString(maximumFractionDigits: 1))
                )
            }
        }

        healthStore.execute(query)
    }
    
    private func fetchWeekRunningStats() {
        let workout = HKSampleType.workoutType()
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: 10, sortDescriptors: nil) { _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil  else {
                print("error fetching total workout data")
                return
            }
            
            var runningCount = 0
            var strenghtCount = 0
            var soccerCount = 0
            var cyclingCount = 0
            var climbingCount = 0
            var footballCount = 0
            for workout in workouts {
                if workout.workoutActivityType  == .running {
                    let duration = Int(workout.duration / 60)
                    runningCount += duration
                } else if workout.workoutActivityType  == .traditionalStrengthTraining {
                    let duration = Int(workout.duration / 60)
                    strenghtCount += duration
                } else if workout.workoutActivityType  == .soccer {
                    let duration = Int(workout.duration / 60)
                    soccerCount += duration
                } else if workout.workoutActivityType  == .cycling {
                    let duration = Int(workout.duration / 60)
                    cyclingCount += duration
                } else if workout.workoutActivityType  == .stairClimbing {
                    let duration = Int(workout.duration / 60)
                    climbingCount += duration
                } else if workout.workoutActivityType  == .americanFootball {
                   let duration = Int(workout.duration / 60)
                    footballCount += duration
               }
            }

            DispatchQueue.main.async { [weak self] in
                self?.activities.append(
                    HKDataItem(type: .running, time: "", value: "\(runningCount)")
                )
                self?.activities.append(
                    HKDataItem(type: .strength, time: "", value: "\(strenghtCount)")
                )
                self?.activities.append(
                    HKDataItem(type: .soccer, time: "", value: "\(soccerCount)")
                )
                self?.activities.append(
                    HKDataItem(type: .cycling, time: "", value: "\(cyclingCount)")
                )
                self?.activities.append(
                    HKDataItem(type: .stairClimbing, time: "", value: "\(climbingCount)")
                )
                self?.activities.append(
                    HKDataItem(type: .football, time: "", value: "\(footballCount)")
                )
            }
        }
        
        healthStore.execute(query)
    }
}

// MARK: Chart
extension HealthManager {
    private func fetchDailyData(type: HKQuantityType, hkUnit: HKUnit,
                                startDate: Date, interval: DateComponents,
                                onCompletion: @escaping([DailyStepView]) -> Void) {
        let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: nil, anchorDate: startDate,
                                                intervalComponents: interval)
        query.initialResultsHandler = { query, results, error in
            guard let unwrappedResults = results else {
                onCompletion([])
                return
            }
            var dailyData = [DailyStepView]()

            unwrappedResults.enumerateStatistics(from: startDate, to: Date()) { statistics, stop in
                if let quantity = statistics.sumQuantity() {
                    dailyData.append(
                        DailyStepView(date: statistics.startDate, stepCount: quantity.doubleValue(for: hkUnit))
                    )
                }
            }

            onCompletion(dailyData)
        }
        
        healthStore.execute(query)
    }
    
    private func fetchAverageData(type: HKQuantityType, hkUnit: HKUnit,
                                  startDate: Date, interval: DateComponents,
                                  onCompletion: @escaping([DailyStepView]) -> Void) {
        let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: nil,
                                                options: [.cumulativeSum], anchorDate: startDate,
                                                intervalComponents: interval)
        query.initialResultsHandler = { query, results, error in
            guard let unwrappedResults = results else {
                onCompletion([])
                return
            }
            var averageData = [DailyStepView]()

            unwrappedResults.enumerateStatistics(from: startDate, to: Date()) { statistics, stop in
               
                if let quantity = statistics.sumQuantity()?.doubleValue(for: hkUnit),
                   let days = Calendar.current.numberOfDaysBetween(statistics.startDate, and: statistics.endDate) {
                    let average = quantity / Double(days)
                    averageData.append(
                        DailyStepView(date: statistics.startDate, stepCount: average)
                    )
                }
            }

            onCompletion(averageData)
        }
        
        healthStore.execute(query)
    }
    
    func fetchDailyChartData(type: HKDataItemType, startDate: Date, interval: DateComponents) {
        func fetchData(type: HKQuantityType, hkUnit: HKUnit) {
            fetchDailyData(type: type, hkUnit: hkUnit, startDate: startDate, interval: interval) { data in
                DispatchQueue.main.async { [weak self] in
                    self?.oneMonthChartData = data
                }
            }
        }
        switch type {
        case .height:
            break
        case .sleep:
            break
        case .steps:
            fetchData(type: .init(.stepCount), hkUnit: .count())
        case .calories:
            fetchData(type: .init(.activeEnergyBurned), hkUnit: .kilocalorie())
        case .running:
            break
        case .strength:
            break
        case .soccer:
            break
        case .stairClimbing:
            break
        case .cycling:
            break
        case .football:
            break
        }
    }
    
    func fetchAverageChartData(type: HKDataItemType, startDate: Date, interval: DateComponents) {
        func fetchData(type: HKQuantityType, hkUnit: HKUnit) {
            fetchAverageData(type: type, hkUnit: hkUnit, startDate: startDate, interval: interval) { data in
                DispatchQueue.main.async { [weak self] in
                    self?.oneMonthChartData = data
                }
            }
        }
        switch type {
        case .height:
            break
        case .sleep:
            break
        case .steps:
            fetchData(type: .init(.stepCount), hkUnit: .count())
        case .calories:
            fetchData(type: .init(.activeEnergyBurned), hkUnit: .kilocalorie())
        case .running:
            break
        case .strength:
            break
        case .soccer:
            break
        case .stairClimbing:
            break
        case .cycling:
            break
        case .football:
            break
        }
    }
}

// MARK: All Records Data
extension HealthManager {
    private func fetchAllWorkoutData(workoutActivityType: HKWorkoutActivityType,
                                     onCompletion: @escaping([ListItem]) -> Void) {
        let workout = HKSampleType.workoutType()
        let timePredicate = HKQuery.predicateForSamples(withStart: .calendarInitialDate, end: Date())
        let workoutPredicate =  HKQuery.predicateForWorkouts(with: workoutActivityType)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil  else {
                print("error fetching total workout data")
                return
            }
            
            var items = [ListItem]()
            for workout in workouts {
                if workout.workoutActivityType  == workoutActivityType {
                    items.insert(
                        ListItem(
                            value: "\(Int(workout.duration / 60))",
                            date: workout.startDate.formattedDateWithDayMonthYear()
                        ), at: 0)
                }
            }
            onCompletion(items)
        }
        
        healthStore.execute(query)
    }

    private func fetchAllData(type: HKQuantityType, hkUnit: HKUnit,
                              maximumFractionDigits: Int,
                              onCompletion: @escaping([ListItem]) -> Void) {
        let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: nil,
                                                anchorDate: .calendarInitialDate,
                                                intervalComponents: DateComponents(day: 1))
        query.initialResultsHandler = { query, results, error in
            guard let unwrappedResults = results else {
                onCompletion([])
                return
            }
            var items = [ListItem]()

            unwrappedResults.enumerateStatistics(from: .calendarInitialDate, to: Date()) { statistics, stop in
                if let quantity = statistics.sumQuantity() {
                    items.insert(
                        ListItem(value: quantity.doubleValue(for: hkUnit).formattedString(maximumFractionDigits: maximumFractionDigits),
                                 date: statistics.startDate.formattedDateWithDayMonthYear())
                        , at: 0
                    )
                }
            }

            onCompletion(items)
        }
        
        healthStore.execute(query)
    }
    
    func fetchAllStepsData(type: HKDataItemType) {
        func fetchData(type: HKQuantityType, hkUnit: HKUnit, maximumFractionDigits: Int) {
            fetchAllData(type: type, hkUnit: hkUnit, maximumFractionDigits: maximumFractionDigits) { items in
                DispatchQueue.main.async { [weak self] in
                    self?.listItems = items
                }
            }
        }
        
        func fetchData(workoutActivityType: HKWorkoutActivityType) {
            fetchAllWorkoutData(workoutActivityType: workoutActivityType) { items in
                DispatchQueue.main.async { [weak self] in
                    self?.listItems = items
                }
            }
        }
        switch type {
        case .height:
            break
        case .sleep:
            break
        case .steps:
            fetchData(type: .init(.stepCount), hkUnit: .count(), maximumFractionDigits: 0)
        case .calories:
            fetchData(type: .init(.activeEnergyBurned), hkUnit: .kilocalorie(), maximumFractionDigits: 1)
        case .running:
            fetchData(workoutActivityType: .running)
        case .strength:
            fetchData(workoutActivityType: .traditionalStrengthTraining)
        case .soccer:
            fetchData(workoutActivityType: .soccer)
        case .stairClimbing:
            fetchData(workoutActivityType: .stairClimbing)
        case .cycling:
            fetchData(workoutActivityType: .cycling)
        case .football:
            fetchData(workoutActivityType: .americanFootball)
        }
    }
}
