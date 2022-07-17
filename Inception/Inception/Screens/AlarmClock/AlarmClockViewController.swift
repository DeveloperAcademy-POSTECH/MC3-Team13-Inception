//
//  AlarmClockViewController.swift
//  Inception
//
//  Created by 김태호 on 2022/07/17.
//

import UIKit

class AlarmClockViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var morningCircle: UIView!
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.numberOfLines = 0
        titleLabel.text = "개운한 아침을 위해" + "\n지금 기상하세요"
        
        morningCircle.layer.masksToBounds = true
        morningCircle.layer.cornerRadius = 135
        morningCircle.layer.borderWidth = 3
        morningCircle.layer.borderColor = UIColor.orange.cgColor

    }

    
    
    
}
