//
//  AlramListCell.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/19.
//

import UIKit

class AlarmListCell: UITableViewCell {
  
  @IBOutlet weak var alarmListCell: UIView!
  
  @IBOutlet weak var bedtimeTitle: UILabel!
  @IBOutlet weak var bedtimeMeridiem: UILabel!
  @IBOutlet weak var bedtimeTime: UILabel!
  
  @IBOutlet weak var wakeuptimeTitle: UILabel!
  @IBOutlet weak var wakeuptimeMeridiem: UILabel!
  @IBOutlet weak var wakeuptimeTime: UILabel!
  
  @IBOutlet weak var sleepHourField: UILabel!
  @IBOutlet weak var sleepHourIcon: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 12))
    sleepHourIcon.image = UIImage(systemName: "bed.double.fill", withConfiguration: configuration)
  }
  
  func alarmCellUpdate(with alarm: Alarm, isSetAlarm: Bool) {
    bedtimeTime.text = alarm.bedtimeTime
    bedtimeMeridiem.text = alarm.bedtimeMeridiem
    wakeuptimeTime.text = alarm.wakeuptimeTime
    wakeuptimeMeridiem.text = alarm.wakeuptimeMeridiem
    sleepHourField.text = String(Float(alarm.expectedSleepHour / 60)) + " 시간"
    
    if isSetAlarm {
      bedtimeTitle.textColor = .white
      bedtimeMeridiem.textColor = .white
      bedtimeTime.textColor = .white
      
      wakeuptimeTitle.textColor = .white
      wakeuptimeMeridiem.textColor = .white
      wakeuptimeTime.textColor = .white
      
      sleepHourField.textColor = .systemOrange
      sleepHourIcon.tintColor = .systemOrange
    } else {
      bedtimeTitle.textColor = .white.withAlphaComponent(0.3)
      bedtimeMeridiem.textColor = .white.withAlphaComponent(0.3)
      bedtimeTime.textColor = .white.withAlphaComponent(0.3)
      
      wakeuptimeTitle.textColor = .white.withAlphaComponent(0.3)
      wakeuptimeMeridiem.textColor = .white.withAlphaComponent(0.3)
      wakeuptimeTime.textColor = .white.withAlphaComponent(0.3)
      
      sleepHourField.textColor = .systemOrange.withAlphaComponent(0.5)
      sleepHourIcon.tintColor = .systemOrange.withAlphaComponent(0.5)
    }
    
  }
  
}
