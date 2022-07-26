//
//  Scheduler.swift
//  Inception
//
//  Created by 김태호 on 2022/07/26.
//

import UIKit

struct Scheduler {
  let userNotificationCenter = UNUserNotificationCenter.current()
  
  // MARK : Notification 권한 요청
  
  func requestNotificationAuthorization() {
    
    let authorizationOption = UNAuthorizationOptions(arrayLiteral: [.alert, .sound])
    
    self.userNotificationCenter.requestAuthorization(options: authorizationOption) { succes, error in
      if let error = error {
        print("error: \(error)")
      }
    }
  }
  
  // MARK : 기상 알림 등록
  
  //편의에 따라 취사선택할 수 있도록 overloading 하였습니다
  func makeMorningNotification(minutes: Double) {
    self.removeAllAlarm()
    
    let seconds = minutes * 60
    
    let content = UNMutableNotificationContent()
    
    content.title = "우리앱"
    content.body = "웨엥웨엥 일어날 시간입니다"
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarmSound.m4a"))
    
    for index in 0...2 {
      let identifier: String = "morning-alarm-\(index)"
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
      let request = UNNotificationRequest(identifier: identifier,
                                          content: content,
                                          trigger: trigger)
      
      self.userNotificationCenter.add(request) { error in
        if error != nil {
          print("somthing went wrong")
        }
      }
    }
  }
  
  func makeMorningNotification(wakeuptimeTime: Date) {
    self.removeAllAlarm()
    
    lazy var wakeupTimeDate = DateComponents()
    
    let content = UNMutableNotificationContent()
    
    let wakeupTimeString = Date().dateTo24HTimeString(wakeuptimeTime)
    let wakeupTimeList = wakeupTimeString.split(separator: ":")
    guard let hour = Int(wakeupTimeList[0]),
          let minute = Int(wakeupTimeList[1]) else { return }
    
    wakeupTimeDate.hour = hour
    wakeupTimeDate.minute = minute
    
    content.title = "우리앱"
    content.body = "웨엥웨엥 일어날 시간입니다"
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarmSound.m4a"))
    
    for index in 0...2 {
      let identifier: String = "morning-alarm-\(index)"
      
      let trigger = UNCalendarNotificationTrigger(dateMatching: wakeupTimeDate, repeats: true)
      let request = UNNotificationRequest(identifier: identifier,
                                          content: content,
                                          trigger: trigger)
      
      self.userNotificationCenter.add(request) { error in
        if error != nil {
          print("somthing went wrong")
        }
      }
    }
  }
  
  
  // MARK : 취침 알림 등록
  
  func makeSleepAlarm(bedTime: Date) {
    if Date() < bedTime {
      let fifteenMinute = 15 * 60
      let bedTimeInterval = Date().minuteInterval(from: Date(), to: bedTime) * 60 - fifteenMinute
      
      let content = UNMutableNotificationContent()
      
      content.title = "우리앱"
      content.body = "이제 잠들 시간 입니다"
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(bedTimeInterval),
                                                      repeats: false)
      let request = UNNotificationRequest(identifier: "sleep-notification",
                                          content: content,
                                          trigger: trigger)
      
      self.userNotificationCenter.add(request) { error in
        if error != nil {
          print("somthing went wrong")
        }
      }
    } else { return }
  }
  
  // MARK : 알림 삭제
  
  func removeAllAlarm() {
    userNotificationCenter.removeAllPendingNotificationRequests()
  }
}
