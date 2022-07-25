//
//  SleepBasedRecoCell.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class SleepBasedRecoCell: UITableViewCell {
  @IBOutlet weak var sleepIcon: UIImageView!
  @IBOutlet weak var sleepHour: UILabel!
  @IBOutlet weak var bedTimeLabel: UILabel!
  @IBOutlet weak var wakeupTimeLabel: UILabel!
  @IBOutlet weak var bedTime: UILabel!
  @IBOutlet weak var wakeupTime: UILabel!
  @IBOutlet weak var addButton: UIButton!
  
  func update(with recoAlarmTime: AlarmTime) {
    sleepHour.text = recoAlarmTime.sleepHour
    bedTime.text = recoAlarmTime.bedTime
    wakeupTime.text = recoAlarmTime.wakeupTime
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
