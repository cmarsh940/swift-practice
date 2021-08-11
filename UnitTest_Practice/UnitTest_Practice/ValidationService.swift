//
//  ValidationService.swift
//  UnitTest_Practice
//
//  Created by Cam on 8/11/21.
//

import Foundation

enum ValidationError: LocalizedError {
    case usernameEmpty
    case passwordEmpty
    case passwordToLong
    case passwordToShort
    case usernameToLong
    case usernameToShort
    
    
    var errorDescription: String? {
        switch self {
        case .usernameEmpty:
            return "Username is empty."
        case .passwordEmpty:
            return "Password is empty."
        case .passwordToLong:
            return "Your password is to long."
        case .passwordToShort:
            return "Your password is to short."
        case .usernameToLong:
            return "Your username is to long."
        case .usernameToShort:
            return "Your username is to short."
        }
    }
    
}


struct ValidationService {
    
    
    func validate(username: String) throws -> String {
        guard !username.isEmpty else { throw ValidationError.usernameEmpty }
        guard username.count > 3 else { throw ValidationError.usernameToShort }
        guard username.count < 20 else { throw ValidationError.usernameToLong }
        return username
    }
    
    
    func validate(password: String) throws -> String {
        guard !password.isEmpty else { throw ValidationError.passwordEmpty }
        guard password.count >= 8 else { throw ValidationError.passwordToShort }
        guard password.count < 20 else { throw ValidationError.passwordToLong }
        return password
    }
    
}
