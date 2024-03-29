//
//  Alarm.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/20.
//  ref: https://nsios.tistory.com/18

import Foundation

struct Alarm: Codable {
  var id: String = UUID().uuidString
  var isOn: Bool
  let bedtimeDate: Date
  let wakeuptimeDate: Date
  
  var bedtimeTime: String {
    return Date().dateTo12HTimeString(bedtimeDate)
  }
  
  var bedtimeMeridiem: String {
    return Date().dateToMeridiemString(bedtimeDate)
  }
  
  var wakeuptimeTime: String {
    return Date().dateTo12HTimeString(wakeuptimeDate)
  }
  
  var wakeuptimeMeridiem: String {
    return Date().dateToMeridiemString(wakeuptimeDate)
  }
  
  var expectedSleepHour: Int {
    return Date().minuteInterval(from: bedtimeDate.addingTimeInterval(60 * 15), to: wakeuptimeDate)
  }
  
  init(isOn: Bool, bedtimeDate: Date, wakeuptimeDate: Date){
    self.isOn = isOn
    self.bedtimeDate = bedtimeDate
    self.wakeuptimeDate = wakeuptimeDate
  }
}

