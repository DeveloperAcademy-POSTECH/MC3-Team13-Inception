//
//  UIViewController+.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/25.
//

import UIKit

extension UIViewController {
  static func instantiateViewController<ViewController: UIViewController>() -> ViewController {
    let identifier: String = String(describing: self)
    
    let storyboard = UIStoryboard(name: identifier, bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            as? ViewController else { fatalError() }
    
    return viewController
  }
}
