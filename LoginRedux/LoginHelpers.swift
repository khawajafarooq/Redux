//
//  LoginHelpers.swift
//  LoginRedux
//
//  Created by GIB on 7/28/18.
//  Copyright © 2018 Xmen. All rights reserved.
//

import Foundation

enum TextState<T> {
    case valid
    case invalid(TextError)
}

enum LoginResult<T> {
    case success(Bool)
    case failure(Error)
}

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

enum TextError: Error {
    case empty(String)
    case invalid(String)
    
    var localizedDescription: String {
        switch self {
        case .empty(let field): return "\(field) is required"
        case .invalid(let field): return "\(field) is invalid"
        }
    }
}
