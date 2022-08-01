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
  
  override func layoutSubviews() {
      super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    self.contentView.layer.cornerRadius = 11
    
    let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 12))
    sleepHourIcon.image = UIImage(systemName: "bed.double.fill", withConfiguration: configuration)
  }
  
  func alarmCellUpdate(with alarm: AlarmItem) {
    
    let convert = Alarm(isOn: alarm.isOn, bedtimeDate: alarm.bedTime!, wakeuptimeDate: alarm.wakeupTime!)
    bedtimeTime.text = convert.bedtimeTime
    bedtimeMeridiem.text = convert.bedtimeMeridiem
    wakeuptimeTime.text = convert.wakeuptimeTime
    wakeuptimeMeridiem.text = convert.wakeuptimeMeridiem
    sleepHourField.text = String(Float(convert.expectedSleepHour) / 60.0) + " 시간"
    
  }
  
}



