//
//  CurrencyTextField.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 09/11/22.
//

import UIKit

class CurrencyTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
    
    var passTextFieldText: ((Double?) -> Void)?
    
    private var amountAsDouble: Double?
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 16
        return rect
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        keyboardType = .numberPad
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    

    @objc private func textFieldDidChange() {
        updateTextField()
    }
    
    private func updateTextField() {
        var cleanedAmount = ""
        
        text?.forEach({ character in
            if character.isNumber {
                cleanedAmount.append(character)
            }
        })
        
        let amount = Double(cleanedAmount) ?? 0.0
        amountAsDouble = (amount / 100.0)
        let amountAsString = numberFormatter.string(from: NSNumber(value: amountAsDouble ?? 0.0)) ?? ""
        
        text = amountAsString
        
        passTextFieldText?(amountAsDouble)
    }
}
