//
//  Scheduler.swift
//  Inception
//
//  Created by 김태호 on 2022/07/26.
//

import UIKit

struct Scheduler {
  let userNotificationCenter = UNUserNotificationCenter.current()
  let musicPlayTime = 29
  
  
  // MARK : Public Fucntions
  
  // Notification 권한 요청
  // TODO: 앱 시작할때 권한 요청하도록 변경
  public func requestNotificationAuthorization() {
    
    let authorizationOption = UNAuthorizationOptions(arrayLiteral: [.alert, .sound])
    
    self.userNotificationCenter.requestAuthorization(options: authorizationOption) { succes, error in
      if let error = error {
        print("error: \(error)")
      }
    }
  }
  
  // 기상 알람 등록
  public func makeMorningNotification(minutes: Double) {
    self.removeAllAlarm()
    
    let seconds = minutes * 60
    
    let content = UNMutableNotificationContent()
    
    content.title = "Sleepie"
    content.body = "웨엥웨엥 일어날 시간입니다"
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarmSound.m4a"))
    
    for index in 0...4 {
      let alarmInterval: Double = seconds + Double(index) * Double(musicPlayTime)
      let identifier: String = "morning-alarm-\(index)"
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: alarmInterval, repeats: false)
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
  
  public func makeMorningNotification(wakeuptimeTime: Date) {
    self.removeAllAlarm()
    
    lazy var wakeupTimeDate = DateComponents()
    
    let content = UNMutableNotificationContent()
    
    let wakeupTimeString = Date().dateTo24HTimeString(wakeuptimeTime)
    let wakeupTimeList = wakeupTimeString.split(separator: ":")
    guard let hour = Int(wakeupTimeList[0]),
          let minute = Int(wakeupTimeList[1]) else { return }
    
    wakeupTimeDate.hour = hour
    wakeupTimeDate.minute = minute
    wakeupTimeDate.second = 0
    
    content.title = "Sleepie"
    content.body = "웨엥웨엥 일어날 시간입니다"
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarmSound.m4a"))
    
    for index in 0...4 {
      let identifier: String = "morning-alarm-\(index)"
      
      wakeupTimeDate.second = musicPlayTime * index
      
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
  
  // 알람 등록
  
  public func makeSleepAlarm(bedTime: Date) {
    let fifteenMinute = TimeInterval(15 * 60)
    if Date() < bedTime - fifteenMinute {
      let bedTimeInterval = Date().secondInterval(from: Date(), to: bedTime) - fifteenMinute
      
      let content = UNMutableNotificationContent()
      
      content.title = "Sleepie"
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
  
  // 알림 삭제

  public func removeAllAlarm() {
    userNotificationCenter.removeAllPendingNotificationRequests()
  }
}
