//
//  ProfileFooterView.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 03/11/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit

class ProfileFooterView: UIView {
    
    // MARK: - Properties
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right: rightAnchor,
                            paddingLeft: 32, paddingRight: 32,
                            height: 50)
        logoutButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
