//
//  SleepTrackerTableViewController.swift
//  Inception
//
//  Created by Jineeee on 2022/07/18.
//

import UIKit

class SleepTrackerTableViewController: UITableViewController {
    
    // 기록 없을 때 나오는 빈 화면
    @IBOutlet var recordEmptyView: UIView!
    
    // Dummy
    
    var dailySleepRecordsDummy = [
        DailySleepTrack(date: "07.14", bedTime: "00:20", wakeTime: "06:36", sleepLength: "6h 16m", sleepCondition: .good),
        DailySleepTrack(date: "07.13", bedTime: "00:11", wakeTime: "06:10", sleepLength: "5h 59m", sleepCondition: .soso),
        DailySleepTrack(date: "07.12", bedTime: "00:20", wakeTime: "06:36", sleepLength: "6h 20m", sleepCondition: .bad),
        DailySleepTrack(date: "07.11", bedTime: "02:20", wakeTime: "06:36", sleepLength: "4h 16m", sleepCondition: .bad),
        DailySleepTrack(date: "07.10", bedTime: "02:16", wakeTime: "03:36", sleepLength: "1h 20m", sleepCondition: .bad),
        DailySleepTrack(date: "07.09", bedTime: "00:20", wakeTime: "06:36", sleepLength: "6h 16m", sleepCondition: .good)
    ]
    //var dailySleepRecordsDummy : [DailySleepTrack] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if dailySleepRecordsDummy.isEmpty {
            tableView.backgroundView = recordEmptyView
        }
        else {
            tableView.backgroundView = nil
        }
        return dailySleepRecordsDummy.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sleepTracker", for: indexPath)  as! DailySleepTrackerTableViewCell
        let dailySleepRecord = dailySleepRecordsDummy[indexPath.row]
        cell.update(with: dailySleepRecord)
        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
