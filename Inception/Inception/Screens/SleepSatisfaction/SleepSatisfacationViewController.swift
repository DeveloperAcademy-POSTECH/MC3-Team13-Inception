//
//  SleepSatisfacationViewController.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/17.
//

import UIKit

enum SleepSatisfacation {
  case good
  case soso
  case bad
  case none
}

final class SleepSatisfacationViewController: UIViewController {
  
  private var selectedEmoji: EmojiButton?
  
  private var sleepSatisfacationSelection: SleepSatisfacation = SleepSatisfacation.none {
    didSet {
      changeSelected(sleepSatisfacationSelection)
    }
  }
  
  
  // MARK: Views
  
  private let stackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.distribution = .fill
    $0.axis = .vertical
    $0.spacing = 15
    $0.alignment = .center
    return $0
  }(UIStackView())
  
  private let titleLabel: UILabel = {
    $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    $0.textColor = .white
    $0.textAlignment = .center
    $0.text = "잘 주무셨나요?"
    return $0
  }(UILabel())
  
  private let descriptionLabel: UILabel = {
    $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    $0.textColor = .white
    $0.textAlignment = .center
    $0.text = "오늘의 수면 상태를 기록하세요"
    return $0
  }(UILabel())
  
  private let emojiStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.distribution = .fill
    $0.axis = .horizontal
    $0.spacing = 17
    $0.alignment = .center
    return $0
  }(UIStackView())
  
  private lazy var emojiButton1: EmojiButton = {
    $0.backgroundColor = .darkGray
    $0.addTarget(self, action: #selector(emojiButtonSelected(_:)), for: .touchUpInside)
    return $0
  }(EmojiButton())
  
  private lazy var emojiButton2: EmojiButton = {
    $0.backgroundColor = .darkGray
    $0.addTarget(self, action: #selector(emojiButtonSelected(_:)), for: .touchUpInside)
    return $0
  }(EmojiButton())
  
  private lazy var emojiButton3: EmojiButton = {
    $0.backgroundColor = .darkGray
    $0.addTarget(self, action: #selector(emojiButtonSelected(_:)), for: .touchUpInside)
    return $0
  }(EmojiButton())
  
  private lazy var saveButton: UIButton = {
    $0.isEnabled = false
    $0.backgroundColor = .systemGray
    $0.setTitleColor(UIColor.white, for: .normal)
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setTitle("저장하기", for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    $0.layer.cornerRadius = 14
    $0.clipsToBounds = true
    $0.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    return $0
  }(UIButton())
  
  private lazy var skipButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setTitle("건너뛰기", for: .normal)
    $0.setUnderline()
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    $0.setTitleColor(UIColor.white, for: .normal)
    $0.addTarget(self, action: #selector(skipButtonDidTap), for: .touchUpInside)
    return $0
  }(UIButton())
  
  private lazy var closeButton: UIButton = {
    let configuration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30))
    let image = UIImage(systemName: "xmark", withConfiguration: configuration)
    $0.setImage(image, for: .normal)
    $0.tintColor = .white
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.addTarget(self, action: #selector(skipButtonDidTap), for: .touchUpInside)
    return $0
  }(UIButton(type: .system))
  
  private let titleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "login_title_icon")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .black
    layout()
    
  }
  
  
  // MARK: Methods
  
  private func layout() {
    view.addSubviews(stackView, closeButton)
    
    stackView.addArrangedSubviews(titleLabel, descriptionLabel, emojiStackView, saveButton, skipButton)
    stackView.setCustomSpacing(100, after: descriptionLabel)
    stackView.setCustomSpacing(109, after: emojiStackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
      closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      closeButton.heightAnchor.constraint(equalToConstant: 30),
      closeButton.widthAnchor.constraint(equalToConstant: 30),
      saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 84),
      saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -84),
      saveButton.heightAnchor.constraint(equalToConstant: 50),
      skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 167),
      skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -167),
    ])
    
    emojiStackView.addArrangedSubviews(emojiButton1, emojiButton2, emojiButton3)
    emojiButton1.configure(with: .init(title: "피곤", emoji: "😣"))
    emojiButton2.configure(with: .init(title: "보통", emoji: "😐"))
    emojiButton3.configure(with: .init(title: "만족", emoji: "😄"))
    
    NSLayoutConstraint.activate([
      emojiButton1.heightAnchor.constraint(equalToConstant: 100),
      emojiButton1.widthAnchor.constraint(equalToConstant: 100),
      emojiButton2.heightAnchor.constraint(equalToConstant: 100),
      emojiButton2.widthAnchor.constraint(equalToConstant: 100),
      emojiButton3.heightAnchor.constraint(equalToConstant: 100),
      emojiButton3.widthAnchor.constraint(equalToConstant: 100)
    ])
    
  }
  
  // emoji button 이 선택되면 저장버튼 활성화
  private func changeSelected(_ index: SleepSatisfacation) {
    saveButton.isEnabled = true
    saveButton.backgroundColor = .systemOrange
    saveButton.setTitleColor(UIColor.black, for: .normal)
  }
  
  @objc private func emojiButtonSelected(_ sender: EmojiButton) {
    
    // 기존에 선택된 버튼인지 확인
    guard selectedEmoji != sender else { return }
    selectedEmoji?.backgroundColor = .darkGray
    
    // 현재 선택된 버튼
    selectedEmoji = sender
    selectedEmoji?.backgroundColor = .systemOrange
    
    switch selectedEmoji {
    case self.emojiButton1 :
      sleepSatisfacationSelection = SleepSatisfacation.bad
    case self.emojiButton2 :
      sleepSatisfacationSelection = SleepSatisfacation.soso
    case self.emojiButton3 :
      sleepSatisfacationSelection = SleepSatisfacation.good
    default:
      print("There's no selection.")
    }
  }
  
  @objc func saveButtonDidTap(_ sender: UIButton) {
    //TODO: 수면기록 저장
    print("수면기록 저장하기 with \(sleepSatisfacationSelection)")
  }
  
  @objc func skipButtonDidTap(_ sender: UIButton) {
    //TODO: 화면 닫기
    print("수면기록 건너뛰기")
  }
  
}

extension SleepSatisfacationViewController {
  
}
