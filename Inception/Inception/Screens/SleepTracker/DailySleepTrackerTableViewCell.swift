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

  func update(with dailySleepRecord : DailySleepTrack) {
    dateLabel.text = dailySleepRecord.date
    bedTimeLabel.text = dailySleepRecord.bedTime
    wakeTimeLabel.text = dailySleepRecord.wakeTime
    sleepLengthLabel.text = dailySleepRecord.sleepLength
    sleepConditionLabel.image = UIImage(systemName: dailySleepRecord.sleepCondition.rawValue)
  }
}
