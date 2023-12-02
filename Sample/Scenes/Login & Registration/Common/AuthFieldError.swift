//
//  LoginError.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import Foundation

enum AuthFieldError: Error {
    case invalidPassword
    case invalidEmail
    case invalidAge
}

extension AuthFieldError {
    var localized: String {
        switch self {
        case .invalidPassword:
            "Number of characters should be between 6 and 12"
        case .invalidEmail:
            "Please enter the valid email"
        case .invalidAge:
            "Age should be between 19 and 99"
        }
    }
}
