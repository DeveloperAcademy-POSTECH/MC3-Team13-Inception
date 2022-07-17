//
//  UIStackView+.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/17.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
          for subview in subviews {
              addArrangedSubview(subview)
          }
    }
}
