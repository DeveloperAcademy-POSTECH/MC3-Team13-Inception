//
//  Alarm.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/20.
//  ref: https://nsios.tistory.com/18

import Foundation

struct Alarm: Codable {
  var id: String = UUID().uuidString
  let bedtimeDate: Date
  let wakeuptimeDate: Date
  var isOn: Bool
  
  var bedtimeTime: String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "hh:mm"
    return timeFormatter.string(from: bedtimeDate)
  }
  
  var bedtimeMeridiem: String {
    let meridiemFormatter = DateFormatter()
    meridiemFormatter.dateFormat = "a"
    meridiemFormatter.locale = Locale(identifier: "ko")
    return meridiemFormatter.string(from: bedtimeDate)
  }
  
  var wakeuptimeTime: String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "hh:mm"
    return timeFormatter.string(from: wakeuptimeDate)
  }
  
  var wakeuptimeMeridiem: String {
    let meridiemFormatter = DateFormatter()
    meridiemFormatter.dateFormat = "a"
    meridiemFormatter.locale = Locale(identifier: "ko")
    return meridiemFormatter.string(from: wakeuptimeDate)
  }
  
  var expectedSleepHour: Int {
    return Int(wakeuptimeDate.timeIntervalSince(bedtimeDate)) / 60
  }
  
}
