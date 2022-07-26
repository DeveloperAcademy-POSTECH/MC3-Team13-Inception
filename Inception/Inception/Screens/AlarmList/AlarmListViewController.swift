//
//  AlarmListViewController.swift
//  Inception
//
//  Created by Mijoo Kim on 2022/07/17.
//

import UIKit

final class AlarmListViewController: UIViewController, Storyboarded {
  
  // MARK: - Properties
  
  @IBOutlet weak var clearPresentAlarmButton: UIButton!
  @IBOutlet weak var presentTableView: UITableView!
  @IBOutlet weak var savedTableView: UITableView!
  @IBOutlet weak var presentTableHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var savedTableHeightConstraint: NSLayoutConstraint!
  
  let rowHeightOfTableView: CGFloat = 123
  let headerHeight: CGFloat = CGFloat.leastNormalMagnitude
  
  let alarmListCellIdentifier: String = "AlarmListCell"
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationItem()
    configureCellForTable()
    setDelegateAndDataSourceForTable()
    initPropertyOfTable()
  }
  
  func setNavigationItem() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집")
  }
  
  func configureCellForTable() {
    let nib = UINib(nibName: alarmListCellIdentifier, bundle: nil)
    presentTableView.register(nib, forCellReuseIdentifier: alarmListCellIdentifier)
    savedTableView.register(nib, forCellReuseIdentifier: alarmListCellIdentifier)
  }
  
  func setDelegateAndDataSourceForTable() {
    presentTableView.delegate = self
    presentTableView.dataSource = self
    savedTableView.delegate = self
    savedTableView.dataSource = self
  }
  
  func initPropertyOfTable() {
    presentTableHeightConstraint.constant = rowHeightOfTableView
    savedTableHeightConstraint.constant = CGFloat(savedAlarm.count) * (rowHeightOfTableView + 15)
    
    presentTableView.isScrollEnabled = false
    savedTableView.isScrollEnabled = false
  }
  
}

// MARK: - UITableViewDataSource

extension AlarmListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if tableView == presentTableView {
      return 1
    }
    else if tableView == savedTableView {
      return savedAlarm.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: alarmListCellIdentifier,
      for: indexPath) as? AlarmListCell
    else { return UITableViewCell() }
    
    cell.layer.cornerRadius = 11
    
    if tableView == self.presentTableView {
      if presentAlarm != nil {
        cell.alarmCellUpdate(with: presentAlarm)
        return cell
      }
    }
    else if tableView == self.savedTableView {
      if savedAlarm.count > 0 {
        cell.alarmCellUpdate(with: savedAlarm[indexPath.row])
        return cell
      }
    }
    return cell
  }
  
}

// MARK: - UITableViewDelegate

extension AlarmListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeightOfTableView 
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return headerHeight
  }
  
}
