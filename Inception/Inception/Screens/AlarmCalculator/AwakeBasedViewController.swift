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
  let data = [TimeDataModel(sleepCycle: "7.5 시간", sleepTime: "오후 11:00", awakeTime: "오전 08:00"),
              TimeDataModel(sleepCycle: "6.0 시간", sleepTime: "오후 12:00", awakeTime: "오전 08:00"),
              TimeDataModel(sleepCycle: "4.5 시간", sleepTime: "오전 01:00", awakeTime: "오전 08:00")]
  
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
    cell.sleepCycle.text = data[indexPath.row].sleepCycle
    cell.sleepLabel.text = "취침"
    cell.awakeLabel.text = "기상"
    cell.sleepTime.text = data[indexPath.row].sleepTime
    cell.awakeTime.text = data[indexPath.row].awakeTime
    
    // 생성한 Cell 리턴
    return cell
  }
  
}
