//
//  ConversationsController.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 24/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit
import Firebase

private let conversationCellIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    private let newMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(handleNewMessageButtonTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        authenticateUser()
    }
    
    // MARK: - Selectors
    
    @objc func showProfile() {
        print(">>> Show profile")
        logout()
    }
    
    @objc func handleNewMessageButtonTap() {
        let newMessageController = NewMessageController()
        newMessageController.delegate = self
        let navigationController = UINavigationController(rootViewController: newMessageController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print(">>> User logged in. Configure controller")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print(">>> User signed out")
            presentLoginScreen()
        } catch let error {
            print(">>> Error signing out: \(error)")
        }
    }
    
    // MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let loginController = LoginController()
            let navigationController = UINavigationController(rootViewController: loginController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain,
                                                           target: self,
                                                           action: #selector(showProfile))
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 56, width: 56)
        newMessageButton.layer.cornerRadius = 56 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.rightAnchor,
                                paddingBottom: 16, paddingRight: 16)
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: conversationCellIdentifier)
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

// MARK: - UITableViewDataSource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: conversationCellIdentifier,
                                                 for: indexPath)
        cell.textLabel?.text = "TestCell"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(">>> Selecter row index: \(indexPath.row)")
    }
}

// MARK: - NewMessageControllerDelegate

extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        let chatController = ChatController(user: user)
        navigationController?.pushViewController(chatController, animated: true)
    }
}
