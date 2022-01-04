//
//  BoardTableViewCell.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import UIKit
import SnapKit

class BoardTableViewCell: UITableViewCell {

    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "머털도사"
        label.backgroundColor = .systemGray5
        label.textColor = .systemGray
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .left
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        textView.text = "코로나로 인해서 일자리도 많이 줄고 취업하기도 어렵구 씁쓸하네요오"
        return textView
    }()
    

    let lineButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupView() {
        [userNameLabel, textView, lineButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        
        lineButton.snp.makeConstraints {    
            $0.top.equalTo(self).offset(10)
            $0.trailing.equalTo(self).offset(-20)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(lineButton)
            $0.leading.equalTo(self).offset(20)
            $0.height.equalTo(15)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(lineButton.snp.bottom).offset(10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.bottom.equalTo(self).offset(-10)
        }
        
    }
}
