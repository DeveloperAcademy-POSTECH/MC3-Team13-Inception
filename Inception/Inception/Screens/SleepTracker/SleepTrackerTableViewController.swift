//
//  SleepTrackerTableViewController.swift
//  Inception
//
//  Created by Jineeee on 2022/07/18.
//

import UIKit

class SleepTrackerTableViewController: UITableViewController, Storyboarded {
  
  /// 기록 없을 때 나오는 빈 화면
  @IBOutlet var recordEmptyView: UIView!
  
  /// 테스트 기록 추가 버튼
  @IBAction func addTestRecord(_ sender: Any) {
    let testAtualSleepTime = -60 * 60 * 6.5
    let temp = SleepRecord(sleepSatisfacation: SleepSatisfacation.good, bedtimeDate: Date.now.addingTimeInterval(testAtualSleepTime), wakeuptimeDate: Date.now)
    
    create(sleepRecordItem: temp)
    fetch()
  }
  
  /// 테스트 전체 삭제 버튼
  @IBAction func deleteAllRecords(_ sender: Any) {
    SleepTrackDataManager.shared.deleteAllSleepRecord()
    fetch()
  }

  private var dailySleepRecords = [SleepRecordItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fetch()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(editButtonDidTap))
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    if dailySleepRecords.isEmpty {
      tableView.isScrollEnabled = false
      tableView.backgroundView = recordEmptyView
    }
    else {
      tableView.backgroundView = nil
    }
    return dailySleepRecords.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "sleepTracker", for: indexPath)  as! DailySleepTrackerTableViewCell
    let dailySleepRecord = dailySleepRecords[indexPath.row]
    cell.update(with: dailySleepRecord)
    return cell
  }

  override func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    var actions = [UIContextualAction]()
    var config = UISwipeActionsConfiguration(actions: actions)
    
    let delete = UIContextualAction(style: .normal, title: nil) { (_, _, completion) in
      SleepTrackDataManager.shared.deleteSleepRecord(self.dailySleepRecords[indexPath.row]) { onSuccess in
        print("deleted = \(onSuccess)")
      }
      self.dailySleepRecords.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }

    let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0,
                                                  weight: .bold,
                                                  scale: .large)
    delete.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
    delete.backgroundColor = .systemBackground
    delete.title = "Delete"

    actions.append(delete)

    config = UISwipeActionsConfiguration(actions: actions)
    config.performsFirstActionWithFullSwipe = false

    return config
  }
  
  private func fetch() {
    dailySleepRecords = SleepTrackDataManager.shared.fetchSleepRecord()
    tableView.reloadData()
  }

  /// 데이터 등록 테스트 위한 임시 함수 (삭제 예정)
  private func create(sleepRecordItem: SleepRecord) {
    let dailyRecordItem = sleepRecordItem

    SleepTrackDataManager.shared.createSleepRecord(trackedDate: dailyRecordItem.trackedDate, bedTime: dailyRecordItem.bedtimeTime, wakeupTime: dailyRecordItem.wakeuptimeDate, actualSleepHour: "\(dailyRecordItem.actualSleepHour/60)h \(dailyRecordItem.actualSleepHour%60)m", sleepSatisfaction: sleepRecordItem.sleepSatisfacation.rawValue) { onSuccess in
      print("saved = \(onSuccess)")
    }
  }
  
  @objc private func editButtonDidTap(_ sender: UIBarButtonItem) {
    if tableView.isEditing {
      tableView.setEditing(false, animated: true)
      sender.title = "편집"
    } else {
      tableView.setEditing(true, animated: true)
      sender.title = "완료"
    }
  }
  
  
}
