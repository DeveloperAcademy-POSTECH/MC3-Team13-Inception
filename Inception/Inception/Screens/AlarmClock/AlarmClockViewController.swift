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
    
    // MARK: 시간 설정
    
    setTime()
    Timer.scheduledTimer(withTimeInterval: 1,  repeats: true){ (_) in
      self.setTime()
    }
    
    // MARK: 그라데이션 원 그리기
    
    drawGradientCircle()
  }
  

  private func setTime(){
    let date = Date()

    let dateFormatter = DateFormatter()
    let ampmFormatter = DateFormatter()

    dateFormatter.dateFormat = "hh: mm"
    ampmFormatter.dateFormat = "a"

    let currentTime = dateFormatter.string(from: date)
    let ampmSetter = ampmFormatter.string(from: date)

    self.timeLabel.text = currentTime
    self.ampmLabel.text = ampmSetter
  }
  
  private func drawGradientCircle() {
    let lineWidth: CGFloat = 3
    let originOffset: CGFloat = lineWidth
    let circleDiameter: CGFloat = 278

    let gradient = CAGradientLayer()

    gradient.frame =  CGRect(origin: CGPoint(x: 0, y:  0),
                             size: morningCircle.frame.size)
    gradient.colors = [UIColor.white.cgColor, UIColor.systemOrange.cgColor]

    let rectangle = CGRect(origin: CGPoint(x: originOffset, y: originOffset),
                           size: CGSize(width: circleDiameter - lineWidth*2,
                                        height: circleDiameter - lineWidth*2))

    let shape = CAShapeLayer()
    shape.lineWidth = lineWidth
    shape.path = UIBezierPath(ovalIn: rectangle).cgPath
    shape.strokeColor = UIColor.black.cgColor
    shape.fillColor = UIColor.clear.cgColor
    gradient.mask = shape
    morningCircle.layer.addSublayer(gradient)
  }
}
