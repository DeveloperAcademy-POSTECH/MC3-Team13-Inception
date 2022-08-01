//
//  AwakeBasedRecommendCell.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class AwakeBasedRecommendCell: UITableViewCell {
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
      message: "한 번에 하나의 알람만 세팅할 수 있어요\n새 알람을 활성화할까요?",
      preferredStyle: UIAlertController.Style.alert
    )
    let confirm = UIAlertAction(title: "변경하기", style: .default) { UIAlertAction in
      // TODO: - '변경하기' 버튼 Action
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
