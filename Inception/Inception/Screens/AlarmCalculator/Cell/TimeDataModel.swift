//
//  TimeDataModel.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import Foundation

struct TimeDataModel {
  var sleepCycle: String
  var sleepTime: String
  var awakeTime: String
  
  init(sleepCycle: String, sleepTime: String, awakeTime: String){
    self.sleepCycle = sleepCycle
    self.sleepTime = sleepTime
    self.awakeTime = awakeTime
  }
}
