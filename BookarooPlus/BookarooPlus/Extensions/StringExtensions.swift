//
//  StringExtensions.swift
//  BookarooPlus
//
//  Created by User on 11.01.2024.
//

import Foundation

extension String {
    func capitalizeEachWord() -> String {
        return self.lowercased()
            .split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }
}
