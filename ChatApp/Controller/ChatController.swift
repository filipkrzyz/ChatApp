//
//  ChatController.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 29/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit

let messageCellIdentifier = "MessageCell"

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
        
        collectionView.register(MessageCell.self,
                                forCellWithReuseIdentifier: messageCellIdentifier)
        collectionView.alwaysBounceVertical = true
    }
}

// MARK: - UICollectionViewDataSource

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageCellIdentifier, for: indexPath) as! MessageCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}
