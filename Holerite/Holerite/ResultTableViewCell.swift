//
//  ResultTableViewCell.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 08/11/22.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let identifier = "ResultTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 15, weight: .bold)
        return text
    }()
    
    private lazy var totalLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var percentageLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .init(rgb: 0x8E8E8E)
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(totalLabel)
        addSubview(percentageLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            percentageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            percentageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            percentageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            totalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            totalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21),
        ])
    }
    
    func setupCell(with result: ResultModel) {
        titleLabel.text = result.title
        totalLabel.attributedText = result.value
        percentageLabel.text = result.subtitle
        totalLabel.textColor =  result.valueColor
    }
}
