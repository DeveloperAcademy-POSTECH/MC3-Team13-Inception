//
//  SleepRecord.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/20.
//

import Foundation

enum SleepSatisfacation: String, Codable {
  case good = "circle"
  case soso = "triangle"
  case bad = "xmark"
  case none = "minus"
}

struct SleepRecord: Codable {
  var id: String = UUID().uuidString
  let bedtimeDate: Date
  let wakeuptimeDate: Date
  var sleepSatisfacation: SleepSatisfacation
  
  var bedtimeTime: String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:MM"
    return timeFormatter.string(from: bedtimeDate)
  }
  
  var wakeuptimeTime: String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:MM"
    return timeFormatter.string(from: wakeuptimeDate)
  }
  
  var actualSleepHour: Int {
    return Int(wakeuptimeDate.timeIntervalSince(bedtimeDate)) / 60
  }
  
  var trackedDate: String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "mm.dd"
    return timeFormatter.string(from: wakeuptimeDate)
  }
  
}
