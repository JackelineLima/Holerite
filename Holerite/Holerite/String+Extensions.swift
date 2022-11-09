//
//  String+Extensions.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 08/11/22.
//

import Foundation

extension String {
    
    public func currencyFormatted() -> String? {
        var textString = self
        guard let regex = try? NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive) else {
            return nil
        }
        
        textString = regex.stringByReplacingMatches(in: textString,
                                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                    range: NSMakeRange(0, textString.count),
                                                    withTemplate: "")

        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale(identifier: "pt_BR")
        
        let double = Double(textString) ?? 0.0
        let number = NSNumber(value: (double / 100))
        return formatter.string(from: number)
    }
}
