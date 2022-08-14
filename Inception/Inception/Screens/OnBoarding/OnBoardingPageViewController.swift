//
//  OnBoardingViewController.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/08/11.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
  
  var pages = [UIViewController]()
  let initialPage = 0
  
  private lazy var pageControl: UIPageControl = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.currentPageIndicatorTintColor = .systemOrange
    $0.pageIndicatorTintColor = .white
    return $0
  }(UIPageControl())
  
  private lazy var skipButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setTitle("건너뛰기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    $0.addTarget(self, action: #selector(skipDidTap(_:)), for: .primaryActionTriggered)
    return $0
  }(UIButton())
  
  private lazy var nextButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setTitle("다음", for: .normal)
    $0.setBackgroundColor(.systemOrange, for: .normal)
    $0.setBackgroundColor(.systemOrange.withAlphaComponent(0.7), for: .selected)
    $0.setTitleColor(UIColor.black, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    $0.layer.cornerRadius = 9
    $0.clipsToBounds = true
    $0.addTarget(self, action: #selector(nextDidTap(_:)), for: .primaryActionTriggered)
    return $0
  }(UIButton())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attributes()
    layout()
  }
  
}

extension OnBoardingPageViewController {
  
  func attributes() {
    dataSource = self
    delegate = self
    
    // pagecontrol dot 로 이동가능하게 함
    pageControl.addTarget(self, action: #selector(pageControlDidTap(_:)), for: .valueChanged)
    
    let page1 = OnboardingViewController(imageName: "onboarding-1")
    let page2 = OnboardingViewController(imageName: "onboarding-2")
    let page3 = OnboardingViewController(imageName: "onboarding-3")
    
    pages.append(page1)
    pages.append(page2)
    pages.append(page3)
    
    setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    
    pageControl.numberOfPages = pages.count
    pageControl.currentPage = initialPage
  }
  
  func layout() {
    view.addSubviews(pageControl, skipButton, nextButton)

    
    NSLayoutConstraint.activate([
      pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
      pageControl.heightAnchor.constraint(equalToConstant: 20),
      pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -36),

      skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),

      nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
      nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      nextButton.heightAnchor.constraint(equalToConstant: 50),

    ])
    
  }
}


// MARK: - DataSources

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
    
    if currentIndex == 0 {
      return nil
    } else {
      return pages[currentIndex - 1]
    }
    
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
    
    if currentIndex < pages.count - 1 {
      return pages[currentIndex + 1]
    } else {
      return nil
    }
  }
  
}

// MARK: - Delegates

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
    guard let viewControllers = pageViewController.viewControllers else { return }
    guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
    
    pageControl.currentPage = currentIndex
    hideControlsIfNeeded()
  }
  
  private func hideControlsIfNeeded() {
    let lastPage = pageControl.currentPage == pages.count - 1
    
    if lastPage {
      hideControls()
    } else {
      showControls()
    }
    
  }
  
  private func hideControls() {
    nextButton.setTitle("시작하기", for: .normal)
    skipButton.layer.isHidden = true
  }
  
  private func showControls() {
    nextButton.setTitle("다음", for: .normal)
    skipButton.layer.isHidden = false
  }
  
}


// MARK: - Actions

extension OnBoardingPageViewController {
  
  @objc func pageControlDidTap(_ sender: UIPageControl) {
    setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    hideControlsIfNeeded()
  }
  
  @objc func skipDidTap(_ sender: UIButton) {
    let lastPage = pages.count - 1
    pageControl.currentPage = lastPage
    
    goToSpecificPage(index: lastPage, ofViewControllers: pages)
    hideControlsIfNeeded()
  }
  
  @objc func nextDidTap(_ sender: UIButton) {
    
    if pageControl.currentPage == pages.count - 1{
      
      let controller = TabBarController()
      controller.modalPresentationStyle = .fullScreen
      UserDefaults.standard.hasOnboarded = true
      self.view.window?.rootViewController = controller
      self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
      
    } else {
      pageControl.currentPage += 1
      goToNextPage()
      hideControlsIfNeeded()
    }
    
  }
}



// MARK: - Extensions

extension UIPageViewController {
  
  func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
    guard let currentPage = viewControllers?[0] else { return }
    guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
    
    setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
  }
  
  func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
    guard let currentPage = viewControllers?[0] else { return }
    guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
    
    setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
  }
  
  func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
    setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
  }
}


