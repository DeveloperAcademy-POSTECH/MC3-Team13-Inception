//
//  InformationTableViewController.swift
//  Inception
//
//  Created by Mijoo Kim on 2022/08/27.
//

import UIKit

class InformationTableViewController: UITableViewController, Storyboarded {
  
  struct Option {
    let title: String
    let handler: () -> Void
  }
  
  private var options = [Option]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureModels()
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return options.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = options[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "InformationViewTableCell", for: indexPath)
    cell.textLabel?.text = model.title
//    cell.selectionStyle = .none
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let model = options[indexPath.row]
      model.handler()
  }
  
  // MARK: - Functions
  
  private func configureModels() {
    options.append(Option(title: "앱 사용 방법", handler: { [weak self] in
      DispatchQueue.main.async {
        self?.goToUserGuidance()
      }
    }))
    
    options.append(Option(title: "개인정보 처리방침", handler: { [weak self] in
      DispatchQueue.main.async {
        self?.goToPrivacyPolicy()
      }
    }))
    
    options.append(Option(title: "팀원 소개", handler: { [weak self] in
      DispatchQueue.main.async {
        self?.goToTeamMemberInfo()
      }
    }))
  }
  
  private func goToUserGuidance() {
    print("goToUserGuidance")
    let userGuidanceViewController = OnBoardingPageViewController()
    navigationController?.pushViewController(userGuidanceViewController, animated: true)
  }
  
  private func goToPrivacyPolicy() {
    print("goToPrivacyPolicy")
    let storyboard = UIStoryboard(name: "PrivacyPolicyViewController", bundle: nil)
    guard let privacyPolicyViewController = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as? PrivacyPolicyViewController else { return }
    navigationController?.pushViewController(privacyPolicyViewController, animated: true)
  }
  
  private func goToTeamMemberInfo() {
    print("goToTeamMemberInfo")
    let storyboard = UIStoryboard(name: "TeamMembersViewController", bundle: nil)
    guard let memberInfoController = storyboard.instantiateViewController(withIdentifier: "teamMemberViewController") as? TeamMembersViewController else { return }
    navigationController?.pushViewController(memberInfoController, animated: true)
  }
  
  
}
