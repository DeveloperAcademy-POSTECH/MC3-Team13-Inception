//
//  AlarmListViewController.swift
//  Inception
//
//  Created by Mijoo Kim on 2022/07/17.
//

import Foundation
import UIKit

class AlarmListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    

    @IBOutlet weak var clearPresentAlarmButton: UIButton!
    @IBOutlet weak var presentTableView: UITableView!
    @IBOutlet weak var savedTableView: UITableView!
    
    let presentAlarms = ["09:00"]
    let savedAlarms = ["10:00", "11:00", "12:00"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTableView.delegate = self
        presentTableView.dataSource = self
        presentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        savedTableView.delegate = self
        savedTableView.dataSource = self
        savedTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }

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
    
}
