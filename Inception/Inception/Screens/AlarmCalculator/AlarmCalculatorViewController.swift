//
//  AlarmCalculatorViewController.swift
//  Inception
//
//  Created by 강은비 on 2022/07/17.
//



import UIKit

class AlarmCalculatorViewController: UIViewController {
  @IBOutlet weak var firstView: UIView!
  @IBOutlet weak var secondView: UIView!

  //세그먼트 컨트롤 뷰를 변경시킴
  @IBAction func switchViews(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      firstView.alpha = 0
      secondView.alpha = 1
    }   else {
      firstView.alpha = 1
      secondView.alpha = 0
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}