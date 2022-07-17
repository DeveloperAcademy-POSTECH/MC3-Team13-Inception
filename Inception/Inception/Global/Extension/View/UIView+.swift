//
//  UIView+.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/17.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
          for view in views {
              addSubview(view)
          }
    }
}

