//
//  Storyboarded.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/26.
//

import UIKit

protocol Storyboarded {
  static func instantiateViewController() -> Self
}

extension Storyboarded {
  static func instantiateViewController() -> Self {
    let identifier: String = String(describing: self)
    
    let storyboard = UIStoryboard(name: identifier, bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else { fatalError() }
    
    return viewController
  }
}
