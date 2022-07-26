//
//  AlarmClockViewController.swift
//  Inception
//
//  Created by 김태호 on 2022/07/17.
//

import UIKit

class AlarmClockViewController: UIViewController {
  let notificationScheduler: Scheduler = Scheduler()
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var wakeupTimeCircle: UIView!
  @IBOutlet weak var meridiemLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.numberOfLines = 0
    titleLabel.text = "개운한 아침을 위해" + "\n지금 기상하세요"
    
    setTime()
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTime),
                         userInfo: nil, repeats : true)
   
    drawGradientCircle()
    
    
    ///  앱이 켜질 경우 Notification에 대한 권한을 얻는 부분입니다
    ///  추후에 main의 ViewController 부분으로 옮길 예정입니다
    notificationScheduler.requestNotificationAuthorization()
  }
  
  // MARK : 시간 설정

  @objc private func setTime(){
    let date = Date()

    let dateFormatter = DateFormatter()
    let meridiemFormatter = DateFormatter()

    dateFormatter.dateFormat = "hh:mm"
    meridiemFormatter.dateFormat = "a"

    let currentTime = dateFormatter.string(from: date)
    let meridiemSetter = meridiemFormatter.string(from: date)

    self.timeLabel.text = currentTime
    self.meridiemLabel.text = meridiemSetter
  }
  
  // MARK : 그라데이션 원 그리기
  
  private func drawGradientCircle() {
    let lineWidth: CGFloat = 3
    let originOffset: CGFloat = lineWidth
    let circleDiameter: CGFloat = 278

    let gradient = CAGradientLayer()

    gradient.frame =  CGRect(origin: CGPoint(x: 0, y:  0),
                             size: wakeupTimeCircle.frame.size)
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
    wakeupTimeCircle.layer.addSublayer(gradient)
  }
}
