//
//  DailySleepTrack.swift
//  SleepTrackerDemo
//
//  Created by Jineeee on 2022/07/17.
//

import Foundation

struct DailySleepTrack {
  
  enum ConditionImages: String {
    case bad = "xmark"
    case soso = "triangle"
    case good = "circle"
    case none = "minus"
  }
  //TODO: DateToString, TimeToString 구현
  var date: String
  var bedTime: String
  var wakeTime: String
  var sleepLength: String
  var sleepCondition: ConditionImages
}

