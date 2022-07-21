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
  var sleepSatisfacation: SleepSatisfacation
  private let bedtimeDate: Date
  private let wakeuptimeDate: Date
  
  var bedtimeTime: String {
    return Date().dateTo24HTimeString(bedtimeDate)
  }
  
  var wakeuptimeTime: String {
    return Date().dateTo24HTimeString(wakeuptimeDate)
  }
  
  var actualSleepHour: Int {
    return Date().minuteInterval(from: bedtimeDate, to: wakeuptimeDate)
  }
  
  var trackedDate: String {
    return Date().dateToStringMMDD(wakeuptimeDate)
  }
  
  init(sleepSatisfacation: SleepSatisfacation, bedtimeDate: Date, wakeuptimeDate: Date) {
    self.sleepSatisfacation = sleepSatisfacation
    self.bedtimeDate = bedtimeDate
    self.wakeuptimeDate = wakeuptimeDate
  }
}
