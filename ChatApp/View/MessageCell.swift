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
        textView.text = "Some test message for now..."
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
        bubbleContainer.anchor(top: topAnchor, left: profileImageView.rightAnchor, paddingLeft: 12)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
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
    
    
}
