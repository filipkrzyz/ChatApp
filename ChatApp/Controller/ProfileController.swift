//
//  ProfileController.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 02/11/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit
import Firebase

let profileCellIdentifier = "ProfileCell"

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private var user: User? {
        didSet {
            headerView.user = user
        }
    }
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0,
                                                             width: view.frame.width,
                                                             height: 380))
    
    private lazy var footerView = ProfileFooterView(frame: .init(x: 0, y: 0,
                                                                 width: view.frame.width,
                                                                 height: 100))
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(ProfileCell.self, forCellReuseIdentifier: profileCellIdentifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = footerView
    }
}

// MARK: - UITableViewDataSource

extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier,
                                                 for: indexPath) as! ProfileCell
        let profileViewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.profileViewModel = profileViewModel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ProfileController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
}
