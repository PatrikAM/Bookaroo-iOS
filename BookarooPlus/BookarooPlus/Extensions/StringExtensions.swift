//
//  StringExtensions.swift
//  BookarooPlus
//
//  Created by User on 11.01.2024.
//

import Foundation
import UIKit

extension String {
    func capitalizeEachWord() -> String {
        return self.lowercased()
            .split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }
    func isValidUrl() -> Bool {
        if let url = NSURL(string: self) {
            if UIApplication.shared.canOpenURL(url as URL) {
                return true
            }
        }
        return false
    }
    func isValidIsbn() -> Bool {
        var cleanedInput = self.cleanNonNumericChars()
        // Remove any hyphens or spaces from the input string
        cleanedInput = cleanedInput.replacingOccurrences(of: "[\\s-]", with: "", options: .regularExpression)
        
        if cleanedInput.count != 10 && cleanedInput.count != 13 {
            return false
        }
        
        if cleanedInput.count == 10 {
            var s = 0
            var t = 0
            
            for digitChar in cleanedInput {
                if let digit = digitChar.wholeNumberValue {
                    t += digit
                    s += t
                }
            }
            return s % 11 == 0
        }
        
        // Check if the input consists of numeric characters only
        if !cleanedInput.allSatisfy({ $0.isNumber }) {
            return false
        }
        
        // Calculate the checksum
        let checksum = cleanedInput.prefix(12).map { Int(String($0))! }
            .enumerated()
            .map { (index, digit) in
                return index % 2 == 0 ? digit : digit * 3
            }
            .reduce(0, +) % 10
        
        // Check if the checksum is correct
        let expectedChecksum = (10 - checksum) % 10
        let actualChecksum = Int(String(cleanedInput.last!))!
        
        return expectedChecksum == actualChecksum
    }
    
    func cleanNonNumericChars() -> String {
        return self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
    
}
