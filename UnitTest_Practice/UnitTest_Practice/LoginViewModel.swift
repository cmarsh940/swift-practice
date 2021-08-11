//
//  LoginViewModel.swift
//  UnitTest_Practice
//
//  Created by Cam on 8/11/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    private var validationService: ValidationService!
    @Published var username: String = ""
    @Published var password: String = ""
    
    init() {
        validationService = ValidationService()
    }
    
    
    func login() {
        do {
            let loggableUser = try validationService.validate(username: username)
            let loggablePassword = try validationService.validate(password: password)
            print("Initiating login for user: \(loggableUser) with password: \(loggablePassword.hash)")
        } catch {
            print("Error logging in: \(error.localizedDescription)")
        }
    }
    
    
    
}
