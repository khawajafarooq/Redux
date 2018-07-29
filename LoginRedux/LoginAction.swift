//
//  LoginAction.swift
//  LoginRedux
//
//  Created by GIB on 7/28/18.
//  Copyright © 2018 Xmen. All rights reserved.
//

import Foundation
import ReSwift

enum LoginAction: Action {
    case typingUsername(TextState<TextError>)
    case typingPassword(TextState<TextError>)
    case loginPress(Result<Bool, APIError>)
}
