//
//  BoardsView.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import UIKit
import SnapKit

class BoardsView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BoardsTableViewCell.self, forCellReuseIdentifier: BoardsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    let composeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupView() {
        
        [tableView, composeButton].forEach { [weak self] in
            self?.addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        composeButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(60)
            $0.trailing.equalTo(self).offset(-50)
            $0.bottom.equalTo(self).offset(-50)
        }
    }
}
