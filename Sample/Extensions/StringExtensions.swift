//
//  StringExtensions.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/28/23.
//

import Foundation

extension String {
    var intValue: Int {
        return Int(self) ?? 0
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
