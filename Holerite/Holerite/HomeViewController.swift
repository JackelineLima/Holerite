//
//  ViewController.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 08/11/22.
//

import UIKit

enum INSS {
    enum baseWage {
        static let first = 1212.02
        static let second = 2427.36
        static let third = 3641.04
        static let last = 7087.22
        static let roof = 828.38
    }
    
    enum basePercentage {
        static let first = 7.5
        static let second = 9.0
        static let third = 12.0
        static let last = 14.0
    }
    
    enum Deduction {
        static let first = 18.18
        static let second = 91.00
        static let last = 163.83
    }
}

enum IRRF {
    enum baseWage {
        static let first = 1903.99
        static let second = 2826.66
        static let third = 3751.06
        static let last = 4664.68
    }
    
    enum basePercentage {
        static let first = 7.5
        static let second = 15.0
        static let third = 22.5
        static let last = 27.5
    }
    
    enum Deduction {
        static let first = 142.80
        static let second = 354.80
        static let third = 636.13
        static let last = 869.36
    }
}

class HomeViewController: UIViewController {
    
    let homeView = HomeView()
    var wage: Double = 0.0
    var discounts: Double = 0.0
    let percentage: Double = 100
    let minimumValue: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        homeView.delegate = self
        navigationItem.title = "Holerite"
        navigationController?.navigationBar.backgroundColor = .white
        view.addSubview(homeView)
        homeView.pin(view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func calculate() -> HoleriteModel {
        var INSSResult: Double = 0.0
        var INSSPercentage: Double = 0.0
        var IRRFResult: Double = 0.0
        var IRRFPercentage: Double = 0.0
        
        let INSS = calculateINSS(with: wage)
        INSS.forEach { inss, percentage in
            INSSResult = inss
            INSSPercentage = percentage
        }
        
        let wageForIRRF = wage - INSSResult
        let IRRF = calculateIRRF(with: wageForIRRF)
        IRRF.forEach { irrf, percentage in
            IRRFResult = irrf
            IRRFPercentage = percentage
        }
        
        let wageWithDiscounts = IRRFResult + INSSResult + discounts
        let totalWage = wage - wageWithDiscounts
        
        return HoleriteModel(wage: wage,
                             totalWage: totalWage,
                             inss: INSSResult,
                             inssPercent: INSSPercentage,
                             irrf: IRRFResult,
                             irrfPercent: IRRFPercentage,
                             discounts: discounts)
    }
    
    func calculateINSS(with wage: Double) -> [Double: Double] {
        
        switch wage {
        case minimumValue..<INSS.baseWage.first:
            return [(wage * INSS.basePercentage.first)/percentage: INSS.basePercentage.first]
        case INSS.baseWage.first..<INSS.baseWage.second:
            return [(wage * INSS.basePercentage.second)/percentage - INSS.Deduction.first: INSS.basePercentage.second]
        case INSS.baseWage.second..<INSS.baseWage.third:
            return [(wage * INSS.basePercentage.third)/percentage - INSS.Deduction.second: INSS.basePercentage.third]
        case INSS.baseWage.third..<INSS.baseWage.last:
            return [(wage * INSS.basePercentage.last)/percentage - INSS.Deduction.last: INSS.basePercentage.last]
        default:
            return [(wage - INSS.baseWage.roof): INSS.baseWage.roof]
        }
    }
    
    func calculateIRRF(with wage: Double) -> [Double: Double] {
        
        switch wage {
        case minimumValue..<IRRF.baseWage.first:
            return [minimumValue: minimumValue]
        case IRRF.baseWage.first..<IRRF.baseWage.second:
            return [(wage * IRRF.basePercentage.first)/percentage - IRRF.Deduction.first: IRRF.basePercentage.first]
        case IRRF.baseWage.second..<IRRF.baseWage.third:
            return [(wage * IRRF.basePercentage.second)/percentage - IRRF.Deduction.second: IRRF.basePercentage.second]
        case IRRF.baseWage.third..<IRRF.baseWage.last:
            return [(wage * IRRF.basePercentage.third)/percentage - IRRF.Deduction.third: IRRF.basePercentage.third]
        default:
            return [(wage * IRRF.basePercentage.last)/percentage - IRRF.Deduction.last: IRRF.basePercentage.last]
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    
    func didValueWage(value: Double?) {
        if let value = value {
            wage = value
        }
    }
    
    func didValueDiscounts(value: Double?) {
        if let value = value {
            discounts = value
        }
    }
    
    func didTapCalcButton() {
        guard wage != minimumValue else { return }
        let controller = ResultViewController(holerite: calculate())
        navigationController?.present(controller, animated: true)
    }
}
