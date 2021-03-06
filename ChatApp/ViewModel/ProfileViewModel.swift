//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 03/11/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Setttings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        }
    }
}
