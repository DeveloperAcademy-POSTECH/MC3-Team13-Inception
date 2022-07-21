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
  
  /// 테스트 기록 추가 버튼
  @IBAction func addTestRecord(_ sender: Any) {
    let testAtualSleepTime = -60 * 60 * 6.5
    let temp = SleepRecord(sleepSatisfacation: SleepSatisfacation.good, bedtimeDate: Date.now.addingTimeInterval(testAtualSleepTime), wakeuptimeDate: Date.now)
    
    saveNewItem(sleepRecordItem: temp)
    fetch()
  }
  
  /// 테스트 전체 삭제 버튼
  @IBAction func deleteAllRecords(_ sender: Any) {
    SleepTrackDataManger.shared.deleteAllItem()
    fetch()
  }

  private var dailySleepRecords = [SleepRecordItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fetch()
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if dailySleepRecords.isEmpty {
      tableView.isScrollEnabled = false
      tableView.backgroundView = recordEmptyView
    }
    else {
      tableView.backgroundView = nil
    }
    return dailySleepRecords.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "sleepTracker", for: indexPath)  as! DailySleepTrackerTableViewCell
    let dailySleepRecord = dailySleepRecords[indexPath.row]
    cell.update(with: dailySleepRecord)
    return cell
  }

  private func fetch() {
    dailySleepRecords = SleepTrackDataManger.shared.getItems()
    tableView.reloadData()
  }

  /// 데이터 등록 테스트 위한 임시 함수 (삭제 예정)
  private func saveNewItem(sleepRecordItem: SleepRecord) {
    let dailyRecordItem = sleepRecordItem

    SleepTrackDataManger.shared.saveItem(trackedDate: dailyRecordItem.trackedDate, bedTime: dailyRecordItem.bedtimeTime, wakeupTime: dailyRecordItem.wakeuptimeTime, actualSleepHour: "\(dailyRecordItem.actualSleepHour/60)h \(dailyRecordItem.actualSleepHour%60)m", sleepSatisfaction: sleepRecordItem.sleepSatisfacation.rawValue) { onSuccess in
      print("saved = \(onSuccess)")
    }
  }
}
