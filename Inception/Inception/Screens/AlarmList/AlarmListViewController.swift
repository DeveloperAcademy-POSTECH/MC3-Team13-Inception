
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
  @IBOutlet weak var presentTableEmptyView: UIView!
  @IBOutlet weak var savedTableEmptyView: UIView!
  
  let rowHeightOfTableView: CGFloat = 139
  let headerHeight: CGFloat = CGFloat.leastNormalMagnitude
  
  let alarmListCellID: String = "AlarmListCell"
  
  private var presentAlarm = [AlarmItem]()
  private var savedAlarm = [AlarmItem]()
  let manager = AlarmDataManger.shared
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    reloadTables(completion: configureCellForTable)
    settingClearButton()
    presentTableEmptyView.isHidden = true
    savedTableEmptyView.isHidden = true
    setNavigationItem()
    setDelegateAndDataSourceForTable()
    initPropertyOfTable()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    reloadTables(completion: settingClearButton)
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
  
  func reloadTables(completion: () -> ()) {
    fetchPresentAlarms(completion: manager.fetchPresentAlarm)
    fetchSavedAlarms(completion: manager.fetchSavedAlarm)
    presentTableView.reloadData()
    savedTableView.reloadData()
    initPropertyOfTable()
    completion()
  }
  
  func fetchPresentAlarms(completion: () -> AlarmItem?) {
    if let fetchPresentAlarm = completion() {
      presentAlarm.append(fetchPresentAlarm)
    }
  }
  
  func fetchSavedAlarms(completion: () -> [AlarmItem]?) {
    if let fetchSavedAlarm = manager.fetchSavedAlarm() {
      savedAlarm = fetchSavedAlarm
    }
  }
  
  func settingClearButton() {
    if !presentAlarm.isEmpty {
      presentTableEmptyView.isHidden = true
      presentTableView.isHidden = false
      clearPresentAlarmButton.isEnabled = true
    }
    else {
      presentTableView.isHidden = true
      presentTableEmptyView.isHidden = false
      clearPresentAlarmButton.isEnabled = false
    }
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
      
      manager.offPresentAlarm() { onSuccess in
      }
      
      savedAlarm.append(presentAlarm.removeLast())
      reloadTables(completion: settingClearButton)
      savedTableHeightConstraint.constant = CGFloat(savedAlarm.count) * (rowHeightOfTableView + 24)
      
      sender.isEnabled = false
    }
  }
}

// MARK: - UITableViewDataSource
extension AlarmListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    var actions = [UIContextualAction]()
    var config = UISwipeActionsConfiguration(actions: actions)
    
    if tableView == presentTableView {
      return config
    }
    else if tableView == savedTableView {
      let delete = UIContextualAction(style: .normal, title: nil) {(_,_, completion) in
        self.manager.deleteAlarm(self.savedAlarm[indexPath.row]) { success in
        }
        self.savedAlarm.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.savedTableHeightConstraint.constant = CGFloat(self.manager.fetchSavedAlarm()?.count ?? 1) * (self.rowHeightOfTableView + 24)
        
        completion(true)
      }
      
      let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
      delete.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
      delete.backgroundColor = .systemBackground
      delete.title = "Delete"
      
      actions.append(delete)
      
      config = UISwipeActionsConfiguration(actions: actions)
      config.performsFirstActionWithFullSwipe = false
      
      return config
    }
    return config
  }
}
