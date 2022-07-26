//
//  SleepBasedViewController.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class SleepBasedViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var isEmpty = true
  var setTime = Date()
  var data = [AlarmTime(sleepHour: "7.5 시간", bedTime: "오후 11:00", wakeupTime: "오전 08:00"),
              AlarmTime(sleepHour: "6.0 시간", bedTime: "오후 11:00", wakeupTime: "오전 07:00"),
              AlarmTime(sleepHour: "4.5 시간", bedTime: "오후 11:00", wakeupTime: "오전 06:00")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let nibName = UINib(nibName: "SleepBasedRecoCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "SleepBasedRecoCell")
  }
  
  @IBAction func changeTimePicker(_ sender: UIDatePicker) {
    let timePickerView = sender
    let formatter = DateFormatter()
    formatter.dateFormat = "a hh:mm"
    
    setTime = timePickerView.date
  }
  
  @IBAction func searchAlarm(_ sender: UIButton) {
    let formatter = DateFormatter()
    formatter.dateFormat = "a hh:mm"
    
    isEmpty = false
    
    data[0].wakeupTime = formatter.string(from: setTime+27000)
    data[1].wakeupTime = formatter.string(from: setTime+21600)
    data[2].wakeupTime = formatter.string(from: setTime+16200)
    
    tableView.reloadData()
  }
  
}

extension SleepBasedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isEmpty {
      return 0
    } else {
      return data.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SleepBasedRecoCell = tableView.dequeueReusableCell(
      withIdentifier: "SleepBasedRecoCell",
      for: indexPath
    ) as! SleepBasedRecoCell
    
    cell.update(with: data[indexPath.row])
    
    return cell
  }
}

extension SleepBasedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120 + 16 // cell size: 120, top padding: 8, bottom padding: 8
  }
}
