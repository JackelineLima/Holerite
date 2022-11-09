//
//  ResultModel.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 09/11/22.
//

import UIKit

struct ResultModel {
    let title: String
    let value: NSAttributedString
    let subtitle: String?
    let valueColor: UIColor?
    
    init(title: String, value: NSAttributedString, subtitle: String? = nil, valueColor: UIColor? = nil) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.valueColor = valueColor
    }
}
