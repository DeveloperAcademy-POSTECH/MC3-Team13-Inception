//
//  SleepTrackerTableViewController.swift
//  Inception
//
//  Created by Jineeee on 2022/07/18.
//

import UIKit

class SleepTrackerTableViewController: UITableViewController {
  
  // 기록 없을 때 나오는 빈 화면
  @IBOutlet var recordEmptyView: UIView!
  
  // MARK: 빈 화면 테스트용 (추후 삭제 예정)
  // 임시 버튼 (추후 삭제 예정)
  @IBOutlet weak var addTestDummyButton: UIBarButtonItem!
  // Dummy
  var dailySleepRecordsDummy : [DailySleepTrack] = []
  
  var dailySleepRecordDummyForAdd = [
    DailySleepTrack(date: "07.14", bedTime: "00:20", wakeTime: "06:36", sleepLength: "6h 16m", sleepCondition: .good),
    DailySleepTrack(date: "07.13", bedTime: "00:11", wakeTime: "06:10", sleepLength: "5h 59m", sleepCondition: .soso),
    DailySleepTrack(date: "07.12", bedTime: "00:20", wakeTime: "06:36", sleepLength: "6h 20m", sleepCondition: .bad),
    DailySleepTrack(date: "07.11", bedTime: "02:20", wakeTime: "06:36", sleepLength: "4h 16m", sleepCondition: .none),
    DailySleepTrack(date: "07.10", bedTime: "02:16", wakeTime: "03:36", sleepLength: "1h 20m", sleepCondition: .bad),
    DailySleepTrack(date: "07.09", bedTime: "00:20", wakeTime: "06:36", sleepLength: "6h 16m", sleepCondition: .good)
  ]

  @IBAction func addTestDummy(_ sender: UIButton) {
    for test in dailySleepRecordDummyForAdd {
      dailySleepRecordsDummy.append(test)
    }
    tableView.reloadData()
  }
  // 여기까지 삭제
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if dailySleepRecordsDummy.isEmpty {
      tableView.isScrollEnabled = false
      tableView.backgroundView = recordEmptyView
    }
    else {
      tableView.isScrollEnabled = true
      tableView.backgroundView = nil
    }
    return dailySleepRecordsDummy.count
  }
  

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "sleepTracker", for: indexPath)  as! DailySleepTrackerTableViewCell
    let dailySleepRecord = dailySleepRecordsDummy[indexPath.row]
    cell.update(with: dailySleepRecord)
    return cell
  }
}
