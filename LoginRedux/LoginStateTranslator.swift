//
//  LoginStateTranslator.swift
//  LoginRedux
//
//  Created by GIB on 7/28/18.
//  Copyright © 2018 Xmen. All rights reserved.
//

import Foundation

class LoginStateTranslator {
    
    // MARK:- Public Properties
    var usernameErrorHidden: Bool
    var passwordErrorHidden: Bool
    var usernameErrorText: String?
    var passwordErrorText: String?
    var loginButtonEnable: Bool
    var loginErrorHidden: Bool
    var loginErrorText: String?
    
    private var isUsernameValid: Bool
    private var isPasswordValid: Bool
    
    init(_ state: LoginState) {
        
        // default state
        usernameErrorHidden = true
        passwordErrorHidden = true
        loginErrorHidden = true
        usernameErrorText = nil
        passwordErrorText = nil
        loginErrorText = nil
        loginButtonEnable = false
        isUsernameValid = false
        isPasswordValid = false
        
        // modeling states
        modelUsernameState(state)
        modelPasswordState(state)
        modelLoginState(state)
    }
    
    
    private func modelUsernameState(_ state: LoginState) {
        switch state.username {
        case .none:
            break
            
        case .invalid(let error)?:
            usernameErrorText = error.localizedDescription
            usernameErrorHidden = false
            loginButtonEnable = false
            isUsernameValid = false
            
        case .valid?:
            usernameErrorText = nil
            usernameErrorHidden = true
            isUsernameValid = true
        
        }
        
        loginButtonEnable = isUsernameValid && isPasswordValid
    }
    
    private func modelPasswordState(_ state: LoginState) {
        switch state.password {
        case .none:
            break
            
        case .invalid(let error)?:
            passwordErrorText = error.localizedDescription
            passwordErrorHidden = false
            loginButtonEnable = false
            isPasswordValid = false
            
        case .valid?:
            passwordErrorText = nil
            passwordErrorHidden = true
            isPasswordValid = true
        }
        
        loginButtonEnable = isUsernameValid && isPasswordValid
    }
    
    private func modelLoginState(_ state: LoginState) {
        switch state.login {
        case .none:
            break
            
        case .success(let login)?:
            if login {
                loginErrorHidden = true
                loginButtonEnable = false
                loginErrorText = nil
            } else {
                loginErrorHidden = false
                loginButtonEnable = true
                loginErrorText = "Failed to login"
            }
            
        case .failure(let error)?:
            loginErrorHidden = false
            loginButtonEnable = true
            loginErrorText = error.localizedDescription
        }
    }
}
