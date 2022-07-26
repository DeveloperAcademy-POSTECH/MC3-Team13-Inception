//
//  Scheduler.swift
//  Inception
//
//  Created by 김태호 on 2022/07/26.
//

import UIKit

class Scheduler {
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
  
  func makeMorningNotification(minutes: Double) {
    let seconds = minutes * 60
    
    self.removeNotification()
    
    let content = UNMutableNotificationContent()
    
    content.title = "우리앱"
    content.body = "웨엥웨엥 일어날 시간입니다"
    
    /// 알림이 일정한 간격을 두고 3번 반복되도록 설정
    for index in 0...2 {
      let alarmInterval: Double = seconds + Double(index) * 10.0
      let identifier: String = "morningAlarm \(index)"
      
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
  
  // MARK : 취침 알림 등록
  
  func makeSleepNotification(minutes : Double) {
    let seconds = minutes * 60
    
    let content = UNMutableNotificationContent()
    content.title = "우리앱"
    content.body = "이제 잠들 시간 입니다"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
    let request = UNNotificationRequest(identifier: "sleep-notification",
                                        content: content,
                                        trigger: trigger)
    
    self.userNotificationCenter.add(request) { error in
      if error != nil {
        print("somthing went wrong")
      }
    }
  }
  
  // MARK : 알림 삭제
  
  func removeNotification() {
    userNotificationCenter.removeAllPendingNotificationRequests()
  }
}
