//
//  ApiError.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import Foundation

enum ApiError: Error {
    case parsingError
    case urlError
    case invalid
    
    var localized: String {
        switch self {
        case .parsingError:
            "Parsing Error"
        case .urlError:
            "Url Error"
        case .invalid:
            "Invalid"
        }
    }
}
