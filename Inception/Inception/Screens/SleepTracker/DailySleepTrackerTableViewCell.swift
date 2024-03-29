//
//  DailySleepTrackerTableViewCell.swift
//  Inception
//
//  Created by Jineeee on 2022/07/18.
//

import UIKit

class DailySleepTrackerTableViewCell: UITableViewCell {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var bedTimeLabel: UILabel!
  @IBOutlet weak var wakeTimeLabel: UILabel!
  @IBOutlet weak var sleepLengthLabel: UILabel!
  @IBOutlet weak var sleepConditionLabel: UIImageView!

  func update(with dailySleepRecord: SleepRecordItem) {
    dateLabel.text = dailySleepRecord.trackedDate
    bedTimeLabel.text = dailySleepRecord.bedTime
    wakeTimeLabel.text = Date().dateTo12HTimeString(dailySleepRecord.wakeupTime!)
    sleepLengthLabel.text = "\(dailySleepRecord.actualSleepHour / 60)h \(dailySleepRecord.actualSleepHour % 60)m "
    sleepConditionLabel.image = UIImage(systemName: dailySleepRecord.sleepSatisfaction!)
  }
}
