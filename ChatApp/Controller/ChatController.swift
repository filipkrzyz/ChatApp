//
//  ChatController.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 29/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    private lazy var customInputAccessoryView: CustomInputAccessoryView = {
        let inputView = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0,
                                                               width: view.frame.height, height: 50))
        return inputView
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputAccessoryView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    }
}
