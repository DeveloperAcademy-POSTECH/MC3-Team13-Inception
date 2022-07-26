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
  @IBOutlet weak var presentTableEmptyView: UIView!
  @IBOutlet weak var savedTableEmptyView: UIView!
  
  let rowHeightOfTableView: CGFloat = 123
  let headerHeight: CGFloat = CGFloat.leastNormalMagnitude
  
  let alarmListCellID: String = "AlarmListCell"
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presentTableEmptyView.isHidden = true
    savedTableEmptyView.isHidden = true
    
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
    let nib = UINib(nibName: alarmListCellID, bundle: nil)
    presentTableView.register(nib, forCellReuseIdentifier: alarmListCellID)
    savedTableView.register(nib, forCellReuseIdentifier: alarmListCellID)
  }
  
  func setDelegateAndDataSourceForTable() {
    presentTableView.delegate = self
    presentTableView.dataSource = self
    savedTableView.delegate = self
    savedTableView.dataSource = self
  }
  
  func initPropertyOfTable() {
    presentTableHeightConstraint.constant = rowHeightOfTableView
    savedTableHeightConstraint.constant = CGFloat(savedAlarm.count) * (rowHeightOfTableView + 24)
    
    presentTableView.isScrollEnabled = false
    savedTableView.isScrollEnabled = false
    
    presentTableView.allowsSelection = false
  }
  
  // MARK: - NavigationBar Button Action
  
  @objc private func editButtonDidTap(_ sender: UIBarButtonItem) {
    if savedTableView.isEditing {
      savedTableView.setEditing(false, animated: true)
      sender.title = "편집"
    } else {
      savedTableView.setEditing(true, animated: true)
      sender.title = "완료"
    }
  }
  
  // MARK: - Clear Present Alarm and Show Empty View
  
  @IBAction func clearPresentAlarm(_ sender: UIButton) {
    if !presentAlarm.isEmpty {
      savedTableEmptyView.isHidden = true
      presentTableView.isHidden = true
      presentTableEmptyView.isHidden = false
      
      savedAlarm.append(presentAlarm.removeLast())
      savedTableView.reloadData()
      savedTableHeightConstraint.constant = CGFloat(savedAlarm.count) * (rowHeightOfTableView + 24)
      
      sender.isEnabled = false
    }
  }
  
}

// MARK: - UITableViewDataSource

extension AlarmListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if tableView == presentTableView {
      if presentAlarm.isEmpty {
        presentTableEmptyView.isHidden = false
        return 0
      }
      return presentAlarm.count
    }
    else if tableView == savedTableView {
      if savedAlarm.isEmpty {
        savedTableEmptyView.isHidden = false
        return 0
      }
      return savedAlarm.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: alarmListCellID,
      for: indexPath) as? AlarmListCell
    else { return UITableViewCell() }
    
    if tableView == self.presentTableView {
      if !presentAlarm.isEmpty {
        cell.alarmCellUpdate(with: presentAlarm[indexPath.row])
        return cell
      }
    } else if tableView == self.savedTableView {
      if !savedAlarm.isEmpty {
        cell.alarmCellUpdate(with: savedAlarm[indexPath.row])
        return cell
      }
    }
    return cell
  }
  
  func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath) {
    if tableView == savedTableView {
      cell.contentView.alpha = 0.8
    }
  }
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      savedAlarm.remove(at: indexPath.row)
      let indexSet = IndexSet(arrayLiteral: indexPath.section)
      tableView.deleteSections(indexSet, with: .fade)
      savedTableHeightConstraint.constant = CGFloat(savedAlarm.count) * (rowHeightOfTableView + 24)
    }
  }
  
}

// MARK: - UITableViewDelegate

extension AlarmListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeightOfTableView
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForHeaderInSection section: Int
  ) -> CGFloat {
    if section == 0 {
      return 0
    }
    return headerHeight
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    if tableView == self.savedTableView {
      return UITableViewCell.EditingStyle.delete
    }
    return UITableViewCell.EditingStyle.none
  }
  
  
}
