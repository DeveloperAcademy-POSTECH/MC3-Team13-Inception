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
  }
  
  @IBAction func snoozeButtonTap(_ sender: Any) {
    notificationScheduler.makeMorningNotification(minutes: 5)
    /// 5분 뒤 버튼이 탭된 이후 알림을 받기 위해 앱을 종료하는 코드입니다
    /// 출처: https://zeddios.tistory.com/1252 [ZeddiOS:티스토리]
    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        exit(0)
    }
  }
  
  @IBAction func turnOffButtonTap(_ sender: Any) {
    notificationScheduler.removeAllAlarm()
    let actualWakeupTimeDate = Date()
    
    /* TODO: CoreDate isOn Alarm 메서드로 설정된 알람 bedtime 받아오기 */
    
    lazy var sleepRecord: SleepRecord = SleepRecord(sleepSatisfacation: .none,
                                                    bedtimeDate: Date(),
                                                    wakeuptimeDate: actualWakeupTimeDate)
    
    SleepTrackDataManager.shared.createSleepRecord(trackedDate: sleepRecord.trackedDate,
                                                   bedTime: sleepRecord.bedtimeTime,
                                                   wakeupTime: sleepRecord.wakeuptimeTime,
                                                   actualSleepHour: String(sleepRecord.actualSleepHour),
                                                   sleepSatisfaction: sleepRecord.sleepSatisfacation.rawValue,
                                                   onSuccess: { onSucess in
      print("onSucess : \(onSucess)")
    })
    /* TODO: 화면 전환 및 SleepRecord 인스턴스 전달 */
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let satisfactionVC = storyboard.instantiateViewController(withIdentifier: "SleepSatisfacationViewController") as? SleepSatisfacationViewController else { return }
    satisfactionVC.sleepRecord = sleepRecord
    satisfactionVC.modalPresentationStyle = .fullScreen
    present(satisfactionVC, animated: true, completion: nil)
  }
}


extension AlarmClockViewController {
  
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
  
  // MARK : 시간 설정

  @objc private func setTime(){
    let date = Date()

    self.timeLabel.text = date.dateTo12HTimeString(date)
    self.meridiemLabel.text = date.dateToMeridiemString(date)
  }
}
