//
//  AlarmCalculatorViewController.swift
//  Inception
//
//  Created by 강은비 on 2022/07/17.
//

import UIKit

class AlarmCalculatorViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var bedTimeBasedView: UIView!
  @IBOutlet weak var wakeupTimeBasedView: UIView!

  //세그먼트 컨트롤 뷰를 변경시킴
  @IBAction func switchViews(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      bedTimeBasedView.alpha = 1
      wakeupTimeBasedView.alpha = 0
    }   else {
      bedTimeBasedView.alpha = 0
      wakeupTimeBasedView.alpha = 1
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
