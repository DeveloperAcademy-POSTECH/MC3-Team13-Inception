//
//  AwakeBasedViewController.swift
//  Inception
//
//  Created by Admin on 2022/07/18.
//

import UIKit

class AwakeBasedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var tableView: UITableView!
  
  // Cell의 Label에 표시할 내용
  let data = [AlarmTime(sleepHour: "7.5 시간", bedTime: "오후 11:00", wakeupTime: "오전 08:00"),
              AlarmTime(sleepHour: "6.0 시간", bedTime: "오후 12:00", wakeupTime: "오전 08:00"),
              AlarmTime(sleepHour: "4.5 시간", bedTime: "오전 01:00", wakeupTime: "오전 08:00")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // Xib로 분할한 Cell 파일 연결을 위한 작업
    let nibName = UINib(nibName: "AwakeBasedRecoCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "AwakeBasedRecoCell")
  }
  
  // 필수 함수 구현
  // 한 섹션(구분)에 몇 개의 셀을 표시할지
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  // 특정 row에 표시할 cell 리턴
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // 내가 정의한 Cell 만들기
    let cell: AwakeBasedRecoCell = tableView.dequeueReusableCell(
      withIdentifier: "AwakeBasedRecoCell",
      for: indexPath
    ) as! AwakeBasedRecoCell
    
    // Cell Label의 내용 지정
    cell.sleepIcon.image = UIImage(systemName: "bed.double.fill")?.withTintColor(
      .systemOrange,
      renderingMode: .alwaysOriginal)
    cell.sleepHour.text = data[indexPath.row].sleepHour
    cell.bedTimeLabel.text = "취침"
    cell.wakeupTimeLabel.text = "기상"
    cell.bedTime.text = data[indexPath.row].bedTime
    cell.wakeupTime.text = data[indexPath.row].wakeupTime
    
    // 생성한 Cell 리턴
    return cell
  }
  
}
