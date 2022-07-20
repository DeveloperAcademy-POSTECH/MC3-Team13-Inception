//
//  SleepBasedViewController.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class SleepBasedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var tableView: UITableView!
  
  let data = [AlarmTime(sleepHour: "7.5 시간", bedTime: "오후 11:00", wakeupTime: "오전 08:00"),
              AlarmTime(sleepHour: "6.0 시간", bedTime: "오후 11:00", wakeupTime: "오전 07:00"),
              AlarmTime(sleepHour: "4.5 시간", bedTime: "오후 11:00", wakeupTime: "오전 06:00")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let nibName = UINib(nibName: "SleepBasedRecoCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "SleepBasedRecoCell")
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SleepBasedRecoCell = tableView.dequeueReusableCell(
      withIdentifier: "SleepBasedRecoCell",
      for: indexPath
    ) as! SleepBasedRecoCell
    
    cell.sleepIcon.image = UIImage(systemName: "bed.double.fill")?.withTintColor(
      .systemOrange,
      renderingMode: .alwaysOriginal
    )
    cell.sleepHour.text = data[indexPath.row].sleepHour
    cell.bedTimeLabel.text = "취침"
    cell.wakeupTimeLabel.text = "기상"
    cell.bedTime.text = data[indexPath.row].bedTime
    cell.wakeupTime.text = data[indexPath.row].wakeupTime
    
    return cell
  }
  
}
