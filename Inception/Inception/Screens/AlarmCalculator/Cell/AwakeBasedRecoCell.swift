//
//  AwakeBasedRecoCell.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class AwakeBasedRecoCell: UITableViewCell {
  @IBOutlet weak var sleepIcon: UIImageView!
  @IBOutlet weak var sleepHour: UILabel!
  @IBOutlet weak var bedTimeLabel: UILabel!
  @IBOutlet weak var wakeupTimeLabel: UILabel!
  @IBOutlet weak var bedTime: UILabel!
  @IBOutlet weak var wakeupTime: UILabel!
  @IBOutlet weak var addButton: UIButton!
  
  @IBAction func addAlarm(_ sender: UIButton) {
    let alert = UIAlertController(title: "현재 알람으로 설정할까요?", message: "한 번에 하나의 알람만 세팅할 수 있어요\n새 알람을 활성화할까요?", preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "변경하기", style: .default) { UIAlertAction in
      print("tanny log--> 변경하기 동작")
    }
    let cancel = UIAlertAction(title: "취소하기", style: .cancel, handler: nil)
    alert.addAction(cancel)
    alert.addAction(okAction)
    alert.preferredAction = okAction
    
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
  }
  
  func update(with recoAlarmTime: AlarmTime) {
    sleepHour.text = recoAlarmTime.sleepHour
    bedTime.text = recoAlarmTime.bedTime
    wakeupTime.text = recoAlarmTime.wakeupTime
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    contentView.layer.cornerRadius = 11
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
