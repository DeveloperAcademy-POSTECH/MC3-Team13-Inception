//
//  AlarmListViewController.swift
//  Inception
//
//  Created by Mijoo Kim on 2022/07/17.
//

import UIKit

final class AlarmListViewController: UIViewController {
  
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
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(editButtonDidTap))
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
    
    presentTableView.allowsSelection = false
  }
  
  @objc private func editButtonDidTap(_ sender: UIBarButtonItem) {
    if savedTableView.isEditing {
      // Edit mode off
      savedTableView.setEditing(false, animated: true)
      sender.title = "편집"
    } else {
      // Edit mode on
      savedTableView.setEditing(true, animated: true)
      sender.title = "완료"
    }
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
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if tableView == self.savedTableView {
      if editingStyle == .delete {
        savedAlarm.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        savedTableHeightConstraint.constant = CGFloat(savedAlarm.count) * rowHeightOfTableView
      }
    }
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
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    if tableView == self.savedTableView {
      return UITableViewCell.EditingStyle.delete
    }
    return UITableViewCell.EditingStyle.none
  }
  
}
