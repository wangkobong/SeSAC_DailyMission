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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
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
        
        [tableView].forEach {
            addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
