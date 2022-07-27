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
    self.contentView.layer.cornerRadius = 11
    
    let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 12))
    sleepHourIcon.image = UIImage(systemName: "bed.double.fill", withConfiguration: configuration)
  }
  
  func alarmCellUpdate(with alarm: Alarm) {
    bedtimeTime.text = alarm.bedtimeTime
    bedtimeMeridiem.text = alarm.bedtimeMeridiem
    wakeuptimeTime.text = alarm.wakeuptimeTime
    wakeuptimeMeridiem.text = alarm.wakeuptimeMeridiem
    sleepHourField.text = String(Float(alarm.expectedSleepHour / 60)) + " 시간"
  }
  
}
