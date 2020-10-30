//
//  MessageCell.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 30/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var message: Message? {
        didSet {
            configure()
        }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor,
                                paddingLeft: 8, paddingBottom: -4)
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor,
                                                                   constant: -12)
        bubbleRightAnchor.isActive = false
        
        bubbleContainer.addSubview(messageTextView)
        messageTextView.anchor(top: bubbleContainer.topAnchor,
                               left: bubbleContainer.leftAnchor,
                               bottom: bubbleContainer.bottomAnchor,
                               right: bubbleContainer.rightAnchor,
                               paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let message = message else { return }
        let messageViewModel = MessageViewModel(message: message)
        
        bubbleContainer.backgroundColor = messageViewModel.messageBackgroundColor
        messageTextView.textColor = messageViewModel.messageTextColor
        messageTextView.text = message.text
        
        bubbleLeftAnchor.isActive = messageViewModel.leftAnchorActive
        bubbleRightAnchor.isActive = messageViewModel.rightAnchorActive
        
        profileImageView.isHidden = messageViewModel.shouldHideProfileImage
    }
}
