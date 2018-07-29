//
//  LoginReducer.swift
//  LoginRedux
//
//  Created by GIB on 7/28/18.
//  Copyright © 2018 Xmen. All rights reserved.
//

import Foundation
import ReSwift

func loginReducer(action: Action, state: LoginState?) -> LoginState {
    var state = state ?? LoginState()
    
    switch action as? LoginAction {
    case .none:
        break
    
    // username state modeling
    case .typingUsername(let textState)?:
        switch textState {
        case .valid: state.username = .valid
        case .invalid (let error): state.username = .invalid(error)
        }
    
    // password state modeling
    case .typingPassword(let textState)?:
        switch textState {
        case .valid: state.password = .valid
        case .invalid (let error): state.password = .invalid(error)
        }
    
    // login state modeling
    case .loginPress(let result)?:
        switch result {
        case .success(let result): state.login = .success(result)
        case .failure(let error): state.login = .failure(error)
        }
    }
    
    return state
}
