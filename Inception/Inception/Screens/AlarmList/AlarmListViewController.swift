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
  @IBOutlet weak var presentTableHeight: NSLayoutConstraint!
  @IBOutlet weak var savedTableHeight: NSLayoutConstraint!

  var presentAlarms = ["10:00"]
  var savedAlarms = ["10:00", "11:00", "12:00","10:00", "11:00",
                     "12:00","10:00", "11:00", "12:00","10:00",
                     "11:00", "12:00","10:00", "11:00", "12:00"]

  let rowHeightOfTableView: CGFloat = 44

  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집")
    
    presentTableView.delegate = self
    presentTableView.dataSource = self
    presentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    savedTableView.delegate = self
    savedTableView.dataSource = self
    savedTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    presentTableHeight.constant = CGFloat(presentAlarms.count) * rowHeightOfTableView
    savedTableHeight.constant = CGFloat(savedAlarms.count) * rowHeightOfTableView
    
    presentTableView.isScrollEnabled = false
    savedTableView.isScrollEnabled = false
    
    presentTableView.allowsSelection = false
  }

}

// MARK: - UITableViewDataSource

extension AlarmListViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if tableView == presentTableView {
      return presentAlarms.count
    }
    else if tableView == savedTableView {
      return savedAlarms.count
    }
    return 0

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    var content = cell.defaultContentConfiguration()

    if tableView == self.presentTableView {
      if presentAlarms.count > 0 {
        content.text = savedAlarms[indexPath.row]
        cell.contentConfiguration = content
        return cell
      }
    }
    else if tableView == self.savedTableView {
      if savedAlarms.count > 0 {
        content.text = savedAlarms[indexPath.row]
        cell.contentConfiguration = content
        return cell
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if tableView == self.savedTableView {
      if editingStyle == .delete {
        savedAlarms.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        savedTableHeight.constant = CGFloat(savedAlarms.count) * rowHeightOfTableView
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
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    
    if tableView == self.savedTableView {
      return UITableViewCell.EditingStyle.delete
    }
    return UITableViewCell.EditingStyle.none
  }
  
}
