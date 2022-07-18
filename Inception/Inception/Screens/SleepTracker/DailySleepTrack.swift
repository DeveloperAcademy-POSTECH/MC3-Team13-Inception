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
    }
    //TODO: DateToString, TimeToString 구현
    var date: String
    var bedTime: String
    var wakeTime: String
    var sleepLength: String
    var sleepCondition: ConditionImages
    
//    init(date: String, bedTime: String, wakeTime: String, sleepLength: String, sleepCondition: ConditionImages) {
//        self.date = date
//        self.bedTime = bedTime
//        self.wakeTime = wakeTime
//        self.sleepLength = sleepLength
//        self.sleepCondition = ConditionImages.bad
//    }
}

