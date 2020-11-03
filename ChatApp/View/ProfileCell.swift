//
//  ProfileCell.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 03/11/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - Propeties
    
    var profileViewModel: ProfileViewModel? {
        didSet {
            configure()
        }
    }
    
    private lazy var iconView: UIView = {
        let view = UIView()
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.centerY(inView: view)
        
        view.backgroundColor = .systemPurple
        view.setDimensions(height: 40, width: 40)
        view.layer.cornerRadius = 40 / 2
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setDimensions(height: 28, width: 28)
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let profileViewModel = profileViewModel else { return }
        
        iconImageView.image = UIImage(systemName: profileViewModel.iconImageName)
        titleLabel.text = profileViewModel.description
    }
}
