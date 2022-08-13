//
//  TeamMembersViewController.swift
//  Inception
//
//  Created by Mijoo Kim on 2022/08/12.
//

import UIKit
import SafariServices

final class TeamMembersViewController: UIViewController, Storyboarded {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func linkToAlolaGit(_ sender: Any) {
    let githubURL = NSURL(string: "https://github.com/compuTasha")
    let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubURL! as URL)
    self.present(githubSafariView, animated: true, completion: nil)
  }
  
  @IBAction func linkToAveryGit(_ sender: Any) {
    let githubURL = NSURL(string: "https://github.com/chaneeii")
    let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubURL! as URL)
    self.present(githubSafariView, animated: true, completion: nil)
  }
  
  @IBAction func linkToMilliGit(_ sender: Any) {
    let githubURL = NSURL(string: "https://github.com/jinccc97")
    let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubURL! as URL)
    self.present(githubSafariView, animated: true, completion: nil)
  }
  
  @IBAction func linkToNeoulGit(_ sender: Any) {
    let githubURL = NSURL(string: "https://github.com/pppaper")
    let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubURL! as URL)
    self.present(githubSafariView, animated: true, completion: nil)
  }
  
  @IBAction func linkToNickGit(_ sender: Any) {
    let githubURL = NSURL(string: "https://github.com/tea-hkim")
    let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubURL! as URL)
    self.present(githubSafariView, animated: true, completion: nil)
  }
  
  @IBAction func linkToTannyGit(_ sender: Any) {
    let githubURL = NSURL(string: "https://github.com/taehyeonk")
    let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubURL! as URL)
    self.present(githubSafariView, animated: true, completion: nil)
  }
}
