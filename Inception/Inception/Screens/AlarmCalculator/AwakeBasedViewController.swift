//
//  AwakeBasedViewController.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class AwakeBasedViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private var setTime = Date()
  private var recoAlarms = [Alarm]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let nibName = UINib(nibName: "AwakeBasedRecommendCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "AwakeBasedRecommendCell")
  }
  
  @IBAction func changeTimePicker(_ sender: UIDatePicker) {
    let timePickerView = sender
    
    if timePickerView.date < Date() - 60 { // Date()는 초단위가 계속 올라가므로 엣지 케이스 처리 불가해서 -1분
      setTime = timePickerView.date + 60*60*24
    } else {
      setTime = timePickerView.date
    }
  }
  
  @IBAction func searchAlarm(_ sender: UIButton) {
    UIView.transition(
      with: tableView,
      duration: 0.3,
      options: .transitionCrossDissolve,
      animations: { self.recoAlarms.removeAll()},
      completion: nil
    )
    for hour in stride(from: 9.0, to: 4.0, by: -1.5) {
      if Date() < setTime - (60*60*hour) - 900 {
        recoAlarms.append(Alarm(isOn: false, bedtimeDate: setTime - (60*60*hour) - 900, wakeuptimeDate: setTime))
      }
    }
    UIView.transition(
      with: tableView,
      duration: 0.3,
      options: .transitionCrossDissolve,
      animations: {self.tableView.reloadData()},
      completion: nil
    )
    
    /* MARK: - 표시할 추천 알람이 하나도 없을 경우의 Alert */
    if recoAlarms.count == 0 {
      let alert = UIAlertController(
        title: "표시할 알람이 없습니다",
        message: "권장 수면 시간에 맞는 알람이 없습니다\n(권장 수면 시간 : 4.5시간 ~ 9시간)",
        preferredStyle: UIAlertController.Style.alert
      )
      let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
      alert.addAction(confirm)
      
      present(alert, animated: true, completion: nil)
    }
  }
  
}

extension AwakeBasedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recoAlarms.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: AwakeBasedRecommendCell = tableView.dequeueReusableCell(
      withIdentifier: "AwakeBasedRecommendCell",
      for: indexPath
    ) as! AwakeBasedRecommendCell
    
    cell.update(with: recoAlarms[indexPath.row])
    
    return cell
  }
}

extension AwakeBasedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120 + 16 // cell size: 120, top padding: 8, bottom padding: 8
  }
}
