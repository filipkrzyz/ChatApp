//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 27/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import Foundation

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var fullname: String?
    var username: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
            && password?.isEmpty == false
    }
}
