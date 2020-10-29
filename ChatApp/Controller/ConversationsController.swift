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
        
        configuteNavigationBar()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain,
                                                           target: self,
                                                           action: #selector(showProfile))
        configureTableView()
    }
    
    func configuteNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
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
