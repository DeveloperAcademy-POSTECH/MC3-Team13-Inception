//
//  AwakeBasedViewController.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class AwakeBasedViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  let data = [AlarmTime(sleepHour: "7.5 시간", bedTime: "오후 11:00", wakeupTime: "오전 08:00"),
              AlarmTime(sleepHour: "6.0 시간", bedTime: "오후 12:00", wakeupTime: "오전 08:00"),
              AlarmTime(sleepHour: "4.5 시간", bedTime: "오전 01:00", wakeupTime: "오전 08:00")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let nibName = UINib(nibName: "AwakeBasedRecoCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "AwakeBasedRecoCell")
  }
  
}

extension AwakeBasedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: AwakeBasedRecoCell = tableView.dequeueReusableCell(
      withIdentifier: "AwakeBasedRecoCell",
      for: indexPath
    ) as! AwakeBasedRecoCell
    
    cell.update(with: data[indexPath.row])
    
    return cell
  }
}

extension AwakeBasedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120 + 16 // cell size: 120, top padding: 8, bottom padding: 8
  }
}
