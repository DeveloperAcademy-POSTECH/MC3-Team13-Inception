//
//  SleepBasedRecoCell.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class SleepBasedRecoCell: UITableViewCell {
  @IBOutlet weak var sleepIcon: UIImageView!
  @IBOutlet weak var sleepCycle: UILabel!
  @IBOutlet weak var sleepLabel: UILabel!
  @IBOutlet weak var awakeLabel: UILabel!
  @IBOutlet weak var sleepTime: UILabel!
  @IBOutlet weak var awakeTime: UILabel!
  @IBOutlet weak var addButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
