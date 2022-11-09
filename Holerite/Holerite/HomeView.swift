//
//  HomeView.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 08/11/22.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapCalcButton()
    func didValueWage(value: Double?)
    func didValueDiscounts(value: Double?)
}

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private lazy var wageTextField: CurrencyTextField = {
        let txt = CurrencyTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 8
        txt.layer.borderColor = UIColor.init(rgb: 0xDCDCDC).cgColor
        txt.layer.borderWidth = 1
        txt.placeholder = "Salário bruto"
        return txt
    }()
    
    private lazy var discountsTextField: CurrencyTextField = {
        let txt = CurrencyTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.backgroundColor = .white
        txt.layer.borderColor = UIColor.init(rgb: 0xDCDCDC).cgColor
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 8
        txt.placeholder = "Descontos"
        return txt
    }()
    
    private lazy var calcButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .init(rgb: 0x4FA6F6)
        btn.layer.cornerRadius = 8
        btn.setTitle("Calcular", for: .normal)
        btn.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(rgb: 0xDADADA)
        setupView()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(wageTextField)
        addSubview(discountsTextField)
        addSubview(calcButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wageTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 33),
            wageTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            wageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            wageTextField.heightAnchor.constraint(equalToConstant: 44),
            
            discountsTextField.topAnchor.constraint(equalTo: wageTextField.bottomAnchor, constant: 12),
            discountsTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            discountsTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            discountsTextField.heightAnchor.constraint(equalToConstant: 44),
            
            calcButton.topAnchor.constraint(equalTo: discountsTextField.bottomAnchor, constant: 22),
            calcButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            calcButton.heightAnchor.constraint(equalToConstant: 50),
            calcButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setupAdditionalConfiguration() {
        wageTextField.delegate = self
        discountsTextField.delegate = self
    }
    
    @objc
    private func didTap() {
        delegate?.didTapCalcButton()
    }
}

extension HomeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case wageTextField:
            wageTextField.passTextFieldText = { amount in
                self.delegate?.didValueWage(value: amount)
            }
        case discountsTextField:
            discountsTextField.passTextFieldText = { amount in
                self.delegate?.didValueDiscounts(value: amount)
            }
        default:
            break
        }
        return true
    }
}
