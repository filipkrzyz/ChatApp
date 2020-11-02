//
//  ConversationCell.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 02/11/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {
    
    // MARK: - Properties
    
    var conversation: Conversation? {
        didSet {
            configure()
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "15 min"
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Username"
        return label
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test message text"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerY(inView: self)
        
        let usernameMessageStack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        usernameMessageStack.axis = .vertical
        usernameMessageStack.spacing = 4
        
        addSubview(usernameMessageStack)
        usernameMessageStack.centerY(inView: profileImageView)
        usernameMessageStack.anchor(left: profileImageView.rightAnchor,
                                    right: rightAnchor,
                                    paddingLeft: 12, paddingRight: 16 )
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let conversation = conversation else { return }
        
        let conversationViewModel = ConversationViewModel(conversation: conversation)
        
        usernameLabel.text = conversation.user.username
        messageTextLabel.text = conversation.message.text
        timestampLabel.text = conversationViewModel.timestamp
        profileImageView.sd_setImage(with: conversationViewModel.profileImageUrl)
        
    }
}
