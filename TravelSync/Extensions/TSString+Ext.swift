//
//  TSString+Ext.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import Foundation

extension String {
    /// Converts an ISO-formatted String from the server into a Swift Date
    ///```
    /// Convert "2026-04-02T05:13:00" to a Date object
    ///```
    var toDate: Date {
        guard let date = try? Date(self, strategy: .iso8601) else {
            print("There was an issue converting ISO-formatted date to swift")
            return .now
        }
        return date
    }
    
    /// Evaluates whether the string is a valid email format.
    ///```
    /// "user@example.com".isValidEmail // true
    /// "userexample.com".isValidEmail // false
    ///```
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    /// Evaluates whether the string meets strong password criteria.
    /// Requires a minimum of 8 characters, 1 uppercase letter, 1 lowercase letter, and 1 number.
    ///```
    /// "SecurePass1".isStrongPassword // true
    /// "weakpass".isStrongPassword // false
    ///```
    var isStrongPassword: Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
}
