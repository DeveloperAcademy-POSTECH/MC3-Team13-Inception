//
//  AlarmTime.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import Foundation

struct AlarmTime {
  var sleepHour: String
  var bedTime: String
  var wakeupTime: String
  
  init(sleepHour: String, bedTime: String, wakeupTime: String){
    self.sleepHour = sleepHour
    self.bedTime = bedTime
    self.wakeupTime = wakeupTime
  }
  
}
