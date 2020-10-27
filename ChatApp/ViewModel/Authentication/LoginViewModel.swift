//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 27/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
}
