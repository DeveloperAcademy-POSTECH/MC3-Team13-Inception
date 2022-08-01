//
//  Date+.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/20.
//

import Foundation

extension Date {

  /**
   # dateTo24HTimeString
   date를 24시간 시각 String 반환해줍니다.
   - Parameters:
     - format: 변형할 DateFormat / Date 타입
   - Note: date -> 23:22 (오전오후 구분X)
   */
  public func dateTo24HTimeString(_ format: Date) -> String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    return timeFormatter.string(from: format)
  }
  
  /**
   # dateTo12HTimeString
   date를 12시간 시각 String 반환해줍니다.
   - Parameters:
     - format: 변형할 DateFormat / Date 타입
   - Note: date -> 10:22 (오전오후 구분X)
   */
  public func dateTo12HTimeString(_ format: Date) -> String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "hh:mm"
    return timeFormatter.string(from: format)
  }

  /**
   # dateToMeridiemString
   date에서 오전/오후 구분을 반환해줍니다.
   - Parameters:
     - format: 변형할 DateFormat / Date 타입
   - Note: date -> 오전
   */
  public func dateToMeridiemString(_ format: Date) -> String {
    let meridiemFormatter = DateFormatter()
    meridiemFormatter.dateFormat = "a"
    meridiemFormatter.locale = Locale(identifier: "ko")
    return meridiemFormatter.string(from: format)
  }
  
  /**
   # minuteInterval
   2개의 date 의 시간간격(분단위)를 계산합니다.
   - Parameters:
     - from : 시작시간 / 잠든시간
     - to : 끝난시간 / 일어난 시간
   - Note: 300 (분)
   */
  public func minuteInterval(from bedtime : Date, to wakeuptime: Date) -> Int {
    return Int(wakeuptime.timeIntervalSince(bedtime)) / 60
  }
  
  /**
   # minuteInterval
   2개의 date 의 시간간격(초단위)를 계산합니다.
   - Parameters:
     - from : 현재 시간
     - to : 취침 시간
   - Note: 300(초)
   */
  public func secondInterval(from currentTime : Date, to bedtime: Date) -> TimeInterval {
    return bedtime.timeIntervalSince(currentTime)
  }
  
  
  /**
   # dateToStringMMDD
   date에서 MM.dd 형태로 날짜를 반환합니다.
   - Parameters:
     - format : 변형할 DateFormat / Date 타입
   - Note: date - > 07/22
   */
  public func dateToStringMMDD(_ format: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM.dd"
    return dateFormatter.string(from: format)
  }
}
