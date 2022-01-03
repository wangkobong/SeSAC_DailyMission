//
//  BoardView.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import UIKit
import SnapKit

class BoardView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
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
