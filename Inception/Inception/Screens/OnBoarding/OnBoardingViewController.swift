//
//  OnBoardingViewController.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/08/12.
//

import UIKit

class OnboardingViewController: UIViewController {

  private let imageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    return $0
  }(UIImageView())
  
  init(imageName: String) {
    super.init(nibName: nil, bundle: nil)
    imageView.image = UIImage(named: imageName)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}

extension OnboardingViewController {
  
  func layout() {
    view.addSubviews(imageView)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}
