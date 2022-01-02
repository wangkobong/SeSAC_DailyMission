//
//  BoardsTableViewCell.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import UIKit
import SnapKit

class BoardsTableViewCell: UITableViewCell {
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "머털도사"
        label.backgroundColor = .systemGray5
        label.textColor = .systemGray
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 10, weight: .light)
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
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = "12/30"
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    let commentImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bubble.right.circle"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let amountCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 4"
        label.backgroundColor = .systemBackground
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
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
        
        [userNameLabel, textView, createdAtLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.leading.equalTo(self).offset(20)
            $0.height.equalTo(15)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(userNameLabel).offset(20)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.bottom.equalTo(createdAtLabel.snp.top).offset(-10)
        }
        
        createdAtLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.bottom.equalTo(self).offset(-10)
        }
        
    }
}
