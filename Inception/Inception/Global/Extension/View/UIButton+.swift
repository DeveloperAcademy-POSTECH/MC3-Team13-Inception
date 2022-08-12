//
//  UIButton+.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/17.
//
//  ref: https://ios-development.tistory.com/742

import UIKit

extension UIButton {
  func setUnderline() {
    guard let title = title(for: .normal) else { return }
    let attributedString = NSMutableAttributedString(string: title)
    attributedString.addAttribute(.underlineStyle,
                                  value: NSUnderlineStyle.single.rawValue,
                                  range: NSRange(location: 0, length: title.count)
    )
    setAttributedTitle(attributedString, for: .normal)
  }
  
  func setImageTintColor(_ color: UIColor) {
    let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
    self.setImage(tintedImage, for: .normal)
    self.tintColor = color
  }
  
  func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
      UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
      guard let context = UIGraphicsGetCurrentContext() else { return }
      context.setFillColor(color.cgColor)
      context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
      
      let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
       
      self.setBackgroundImage(backgroundImage, for: state)
  }

}
