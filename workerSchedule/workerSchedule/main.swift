//
//  main.swift
//  workerSchedule
//
//  Created by Kira on 15.10.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

enum ShiftTypes: String, CaseIterable {
    case day = "day"
    case night = "night"
    case free1 = "first_free"
    case free2 = "second_free"
    
    /*
     Возможно было решить задание, используя только данный метод
     */
    func getNext(element: Self) -> Self? {
        let allCases = Self.allCases
        guard let indexOfElement = allCases.firstIndex(of: element) else { return nil }
        
        return allCases[(indexOfElement + 1) % allCases.count]
    }
}

/**
 Основная функция. Без обработки ошибок
 */
func getShiftBySchedule() {
    
    var input = ""
    var month: Int = 0
    var day: Int = 0
    
    let shiftTypesArray = ShiftTypes.allCases.map({ (type) -> String in
        return type.rawValue
    })
    
    while !shiftTypesArray.contains(input) {
        print("Enter work shift on the first Jenuary (e.g. \(shiftTypesArray.joined(separator: ", "))) or \"exit\" to stop the program")
        input = String(readLine(strippingNewline: true)!)
        if (input == "exit") {
            return
        }
    }
    
    guard let shiftType = ShiftTypes.init(rawValue: input) else { return }
    let calendar = Calendar.current
    let year = calendar.component(.year, from: Date())
      
    guard let firstOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1)) else { return }
    guard let lastOfYear = calendar.date(from: DateComponents(year: year, month: 12, day: 31)) else { return }
      
    guard let schedule = createScheduleBy(firstDayShiftType: shiftType, startDate: firstOfYear, lastDate: lastOfYear) else { return }
    
    while month > 12 || month < 1 {
        print("Enter month (1-12)")
        month = Int(readLine(strippingNewline: true)!) ?? 0
    }
    
    while day > 31 || day < 1 {
        print("Enter day (1-31)")
        day = Int(readLine(strippingNewline: true)!) ?? 0
    }
    
    guard let shiftDate = getDateBy(month: month, day: day) else { return }
    guard let resultShift = schedule[shiftDate]?.rawValue else { return }
    print("\(shiftDate) is \(resultShift)")
}

/**
 Данный подход к выполнению задания был выбран для проработки операций с массивами / перечислениями
 */
func createScheduleBy(firstDayShiftType: ShiftTypes, startDate: Date, lastDate: Date) -> [String: ShiftTypes]? {
    
    let period = createPeriodBy(firstDate: startDate, lastDate: lastDate)
    let spreadingRemain = period.count % ShiftTypes.allCases.count
    
    var shiftQueue = [ShiftTypes]()
    var repeatShifts = [ShiftTypes]()
    var currentShift = firstDayShiftType
    
    if (spreadingRemain > 0) {
        for _ in 1...spreadingRemain {
            shiftQueue.append(currentShift)
            guard let nextElement = currentShift.getNext(element: currentShift) else { return nil }
            currentShift = nextElement
        }
        
        for _ in 1...ShiftTypes.allCases.count {
            repeatShifts.append(currentShift)
            guard let nextElement = currentShift.getNext(element: currentShift) else { return nil }
            currentShift = nextElement
        }
    } else {
        repeatShifts = ShiftTypes.allCases
    }
    
    shiftQueue += Array.init(repeating: repeatShifts, count: period.count / ShiftTypes.allCases.count).flatMap{$0}
    
    return Dictionary(uniqueKeysWithValues: zip(period,shiftQueue))
}

func createPeriodBy(firstDate: Date, lastDate: Date, dateFormat: String = "dd.MM.yyyy") -> [String] {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    
    var currentDate = firstDate
    var period : [String] = []
    
    while currentDate <= lastDate {
        period.append(formatter.string(from: currentDate))
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    return period
}

/**
 При получении варианта несуществующего дня (31.09) получаем слудующий день, пока не знаю как решить данный момент нативно
 */
func getDateBy(month: Int, day: Int, dateFormat: String = "dd.MM.yyyy") -> String? {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: Date())
    
    guard let resultDate = calendar.date(from: DateComponents(year: year, month: month, day: day)) else { return nil }
    
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    
    return formatter.string(from: resultDate)
}

getShiftBySchedule()

