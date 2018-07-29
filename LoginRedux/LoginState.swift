//
//  LoginState.swift
//  LoginRedux
//
//  Created by GIB on 7/28/18.
//  Copyright © 2018 Xmen. All rights reserved.
//

import Foundation
import ReSwift

struct LoginState: StateType {
    var username: TextState<String>? = nil
    var password: TextState<String>? = nil
    var login: LoginResult<Result<Bool, APIError>>? = nil
}
