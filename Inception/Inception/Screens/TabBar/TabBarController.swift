//
//  TabBarController.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/25.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    attributes()
    setUpTabBar()
    
  }
  
  private func attributes() {
    tabBar.tintColor = UIColor.orange
    tabBar.unselectedItemTintColor = UIColor.lightGray
  }
  
  private func setUpTabBar() {
    
    /* MARK: - Tab 1 알람설정 */
    let alarmCalculator = AlarmCalculatorViewController.instantiateViewController()
    let alarmCalculatorViewController = UINavigationController(rootViewController: alarmCalculator)
    alarmCalculatorViewController.tabBarItem = UITabBarItem.init(title: "알람추천", image: UIImage(systemName: "plus.square"), tag: 0)
    alarmCalculatorViewController.navigationBar.prefersLargeTitles = true
    
    /* MARK: - Tab 2 알람목록 */
    let alarmList = AlarmListViewController.instantiateViewController()
    let alarmListViewController = UINavigationController(rootViewController: alarmList)
    alarmListViewController.tabBarItem = UITabBarItem.init(title: "알람목록", image: UIImage(systemName: "list.dash"), tag: 1)
    alarmListViewController.navigationBar.prefersLargeTitles = true
    
    /* MARK: - Tab 3 수면기록 */
    let sleepTracker = SleepTrackerTableViewController.instantiateViewController()
    let sleepTrackerViewController = UINavigationController(rootViewController: sleepTracker)
    sleepTrackerViewController.tabBarItem = UITabBarItem.init(title: "수면기록", image: UIImage(systemName: "chart.pie"), tag: 2)
    sleepTrackerViewController.navigationBar.prefersLargeTitles = true
    
    viewControllers = [alarmCalculatorViewController, alarmListViewController, sleepTrackerViewController]
    
  }
  
}
