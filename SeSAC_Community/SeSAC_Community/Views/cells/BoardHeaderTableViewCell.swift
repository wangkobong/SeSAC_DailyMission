//
//  BoardHeaderTableViewCell.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/04.
//

import UIKit
import SnapKit

class BoardHeaderTableViewCell: UITableViewCell {
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "머털도사"
        label.backgroundColor = .systemBackground
        label.textColor = .black
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
    }()
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = "12/30"
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    
    let textView2: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .left
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        textView.text = "코로나로 인해서 일자리도 많이 줄고 취업하기도 어렵구 씁쓸하네요오"
        return textView
    }()
    

    let firstSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    let secondSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let thirdSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let commentImageView2: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bubble.right.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
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
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
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
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(createdAtLabel)
        
        [avatarImageView, textView2, amountCommentLabel, firstSeparator, secondSeparator, stackView, thirdSeparator, commentImageView2].forEach {
            addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalTo(self).offset(30)
            $0.leading.equalTo(self).offset(20)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(self).offset(30)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(self)
            $0.height.equalTo(30)
        }

        firstSeparator.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self)
            $0.height.equalTo(1)
        }

        textView2.snp.makeConstraints {
            $0.top.equalTo(firstSeparator.snp.bottom).offset(20)
            $0.bottom.equalTo(self)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
        }

        secondSeparator.snp.makeConstraints {
            $0.bottom.equalTo(commentImageView2.snp.top).offset(-10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self)
            $0.height.equalTo(1)
        }

        commentImageView2.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.bottom.equalTo(thirdSeparator.snp.top).offset(-10)
            $0.width.equalTo(25)
            $0.height.equalTo(20)
        }

        amountCommentLabel.snp.makeConstraints {
            $0.leading.equalTo(commentImageView2.snp.trailing).offset(8)
            $0.bottom.equalTo(thirdSeparator.snp.top).offset(-10)
            $0.height.equalTo(20)
        }


        thirdSeparator.snp.makeConstraints {
            $0.bottom.equalTo(self)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self)
            $0.height.equalTo(0.1)
        }

    }
}

