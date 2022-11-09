//
//  ResultViewController.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 08/11/22.
//

import UIKit

class ResultViewController: UIViewController {
    
    lazy var resultView = ResultView()
    let holerite: HoleriteModel
    
    init(holerite: HoleriteModel) {
        self.holerite = holerite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Holerite"
        
        resultView.setup(result: setup())
    }
    
    override func loadView() {
        super.loadView()
        resultView.delegate = self
        view = resultView
    }
    
    private func setup() -> [ResultModel] {
        let model: [ResultModel] = [
            ResultModel(title: "Salário Bruto",
                        value: atributted(with: holerite.wage),
                        valueColor: .init(rgb: 0x42A640)),
            ResultModel(title: "Descontos",
                        value: atributted(with: holerite.discounts),
                        valueColor: setupLayoutDiscounts(value: holerite.discounts)),
            ResultModel(title: "Descontos INSS",
                        value: atributted(with: holerite.inss),
                        subtitle: "\(holerite.inssPercent)%",
                        valueColor: setupLayoutDiscounts(value: holerite.inss)),
            ResultModel(title: "Descontos IRRF",
                        value: atributted(with: holerite.irrf),
                        subtitle: "\(holerite.irrfPercent)%",
                        valueColor: setupLayoutDiscounts(value: holerite.irrf)),
            ResultModel(title: "Salário Liquido",
                        value: atributted(with: holerite.totalWage),
                        valueColor: .init(rgb: 0x42A640))]
        
        return model
    }
    
    private func setupLayoutDiscounts(value: Double) -> UIColor {
        if value != 0.0 {
            return .init(rgb: 0xDB4239)
        }
        return .init(rgb: 0x8E8E8E)
    }
    
    private func atributted(with value: Double) -> NSAttributedString {
        if value == 0.0 {
            return NSAttributedString(
                string: "R$ \(value)",
                attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue]
            )
        }
        return NSAttributedString(
            string: String(format: "%.2f", value),
            attributes: [:]
        )
    }
}

extension ResultViewController: ResultViewDelegate {
    
    func didTapCloseButton() {
        dismiss(animated: true)
    }
}
