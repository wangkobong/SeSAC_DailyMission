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
        tableView.register(BoardHeaderTableViewCell.self, forCellReuseIdentifier: BoardHeaderTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    let commentField: UITextField = {
        let field = UITextField()
        field.keyboardType = .namePhonePad
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "댓글을 입력해주세요"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 20
        field.layer.masksToBounds = true
        return field
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
        
        [tableView, commentField].forEach {
            addSubview($0)
        }
        
    }
    
    internal func setupConstraints() {
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        commentField.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self).offset(10)
            $0.trailing.equalTo(self).offset(-10)
            $0.height.equalTo(50)
        }
        
    }
}
