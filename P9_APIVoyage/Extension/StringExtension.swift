//
//  StringExtension.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 23/03/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation

/// String extension to add the splice fonction
extension String {
    /// Slice the string value to get the string between two range
    /// - Parameters:
    ///   - from: beginning string
    ///   - to: ended string
    /// - Returns: String between beginning string and ended string
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
