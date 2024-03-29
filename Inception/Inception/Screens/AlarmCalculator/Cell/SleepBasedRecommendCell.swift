//
//  SleepBasedRecommendCell.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class SleepBasedRecommendCell: UITableViewCell {
  private let notificationCenter: Scheduler = Scheduler()
  private var cellBedTime = Date()
  private var cellWakeupTime = Date()
  
  @IBOutlet weak var sleepIcon: UIImageView!
  @IBOutlet weak var sleepHour: UILabel!
  @IBOutlet weak var bedTimeLabel: UILabel!
  @IBOutlet weak var wakeupTimeLabel: UILabel!
  @IBOutlet weak var bedTime: UILabel!
  @IBOutlet weak var wakeupTime: UILabel!
  @IBOutlet weak var addButton: UIButton!
  
  @IBAction func addAlarm(_ sender: UIButton) {
    let alert = UIAlertController(
      title: "현재 알람으로 설정할까요?",
      message: """
      한 번에 하나의 알람만 세팅할 수 있어요
      새 알람을 활성화할까요?
      
      (⚠️ 무음모드, 방해금지 모드에서는
      알람이 울리지 않습니다)
      """,
      preferredStyle: UIAlertController.Style.alert
    )
    let confirm = UIAlertAction(
    title: AlarmDataManger.shared.fetchPresentAlarm() == nil ? "확인하기" : "변경하기",
    style: .default
    ) { UIAlertAction in
      let id = Date().dateTo24HTimeString(self.cellBedTime) + Date().dateTo24HTimeString(self.cellWakeupTime)
      AlarmDataManger.shared.createAlarmItem(
        id : id,
        bedTime: self.cellBedTime,
        wakeupTime: self.cellWakeupTime
      ) { onSuccess in }
      
      self.notificationCenter.makeMorningNotification(wakeuptimeTime: self.cellWakeupTime)
      self.notificationCenter.makeSleepAlarm(bedTime: self.cellBedTime)
      
      if let tabBarController = self.window?.rootViewController as? UITabBarController {
        let tabItem = tabBarController.tabBar.items?[1]
        tabItem?.badgeValue = "new"
      }
    }
    let cancel = UIAlertAction(title: "취소하기", style: .cancel, handler: nil)
    alert.addAction(cancel)
    alert.addAction(confirm)
    alert.preferredAction = confirm
    
    UIApplication.firstKeyWindowForConnectedScenes?.rootViewController?.present(alert, animated: true, completion: nil)
  }
  
  func update(with recoAlarmTime: Alarm) {
    sleepHour.text = String(format: "%.1f", Float(recoAlarmTime.expectedSleepHour) / 60.0) + " 시간"
    bedTime.text = recoAlarmTime.bedtimeMeridiem + " " + recoAlarmTime.bedtimeTime
    wakeupTime.text = recoAlarmTime.wakeuptimeMeridiem + " " + recoAlarmTime.wakeuptimeTime
    
    cellBedTime = recoAlarmTime.bedtimeDate
    cellWakeupTime = recoAlarmTime.wakeuptimeDate
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
