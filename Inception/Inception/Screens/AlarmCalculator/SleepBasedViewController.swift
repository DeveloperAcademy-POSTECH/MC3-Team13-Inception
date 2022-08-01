//
//  SleepBasedViewController.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class SleepBasedViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private var setTime = Date()
  private var recoAlarms = [Alarm]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let nibName = UINib(nibName: "SleepBasedRecommendCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "SleepBasedRecommendCell")
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
    for hour in stride(from: 4.5, to: 9.5, by: 1.5) {
      recoAlarms.append(Alarm(isOn: false, bedtimeDate: setTime, wakeuptimeDate: setTime + (60*60*hour) + 900))
    }
    UIView.transition(
      with: tableView,
      duration: 0.3,
      options: .transitionCrossDissolve,
      animations: {self.tableView.reloadData()},
      completion: nil
    )
  }
  
}

extension SleepBasedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recoAlarms.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SleepBasedRecommendCell = tableView.dequeueReusableCell(
      withIdentifier: "SleepBasedRecommendCell",
      for: indexPath
    ) as! SleepBasedRecommendCell
    
    cell.update(with: recoAlarms[indexPath.row])
    
    return cell
  }
}

extension SleepBasedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120 + 16 // cell size: 120, top padding: 8, bottom padding: 8
  }
}
