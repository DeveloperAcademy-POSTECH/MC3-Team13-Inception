//
//  AwakeBasedRecoCell.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class AwakeBasedRecoCell: UITableViewCell {
  
  @IBOutlet weak var sleepCycle: UILabel!
  @IBOutlet weak var sleepLabel: UILabel!
  @IBOutlet weak var awakeLabel: UILabel!
  @IBOutlet weak var sleepTime: UILabel!
  @IBOutlet weak var awakeTime: UILabel!
  @IBOutlet weak var addButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
