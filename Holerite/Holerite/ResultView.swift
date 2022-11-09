//
//  ResultView.swift
//  Holerite
//
//  Created by Jackeline Pires De Lima on 08/11/22.
//

import UIKit

protocol ResultViewDelegate: AnyObject {
    func didTapCloseButton()
}

final class ResultView: UIView {
    
    var result: [ResultModel] = []
    
    weak var delegate: ResultViewDelegate?
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("FECHAR", for: .normal)
        btn.setTitleColor(.init(rgb: 0x343434), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        btn.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .init(rgb: 0xDADADA)
        table.delegate = self
        table.dataSource = self
        table.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        return table
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .init(rgb: 0xDADADA)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(closeButton)
        addSubview(tableview)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            closeButton.heightAnchor.constraint(equalToConstant: 18),
   
            tableview.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 28),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func didTapClose() {
        delegate?.didTapCloseButton()
    }
    
    func setup(result: [ResultModel]) {
        self.result = result
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

extension ResultView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: result[indexPath.row])
        return cell
    }
}

