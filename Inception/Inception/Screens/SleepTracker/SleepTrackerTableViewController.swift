//
//  SleepTrackerTableViewController.swift
//  Inception
//
//  Created by Jineeee on 2022/07/18.
//

import UIKit

class SleepTrackerTableViewController: UITableViewController {
  
  /// 기록 없을 때 나오는 빈 화면
  @IBOutlet var recordEmptyView: UIView!


  var dailySleepRecords : [DailySleepTrack] = []

  override func viewDidLoad() {
    super.viewDidLoad()
  
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if dailySleepRecords.isEmpty {
      tableView.isScrollEnabled = false
      tableView.backgroundView = recordEmptyView
    }
    return dailySleepRecords.count
  }
  

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "sleepTracker", for: indexPath)  as! DailySleepTrackerTableViewCell
    let dailySleepRecord = dailySleepRecords[indexPath.row]
    cell.update(with: dailySleepRecord)
    return cell
  }
}
