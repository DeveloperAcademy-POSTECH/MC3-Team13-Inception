//
//  EmojiButton.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/07/17.
//

import UIKit

struct EmojiButtonViewModel {
    let title: String
    let emoji: String
}

class EmojiButton: UIButton {
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private let emojiTitle: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 12 , weight: .medium)
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let emojiIcon: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 40)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    
    private var viewModel: EmojiButtonViewModel?
    
    override init(frame: CGRect){
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: EmojiButtonViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        configure(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel:EmojiButtonViewModel ){
        layer.masksToBounds = true
        layer.cornerRadius = 10
        isUserInteractionEnabled = true
        
        emojiTitle.text = viewModel.title
        emojiIcon.text = viewModel.emoji
        
        addSubviews(emojiIcon,emojiTitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        emojiIcon.frame = CGRect(x: 0, y: 15, width: frame.width, height: 40).integral
        emojiTitle.frame = CGRect(x: 0, y: 70, width: frame.width, height: 15).integral
    }
    
}
