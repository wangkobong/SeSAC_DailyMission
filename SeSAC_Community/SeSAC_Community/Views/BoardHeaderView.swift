//
//  BoardHeaderView.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import UIKit
import SnapKit

class BoardHeaderView: UIView {
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
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
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = "12/30"
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
    
    let commentImageView: UIImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupView() {
        
        [avatarImageView, userNameLabel, textView, createdAtLabel, commentImageView, amountCommentLabel, firstSeparator, secondSeparator, stackView].forEach {
            addSubview($0)
        }
        
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(createdAtLabel)
    }
    
    internal func setupConstraints() {
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalTo(self).offset(30)
            $0.leading.equalTo(self).offset(20)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(avatarImageView)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.height.equalTo(avatarImageView)
        }
        
        firstSeparator.snp.makeConstraints {
            $0.top.equalTo(stackView).offset(20)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self)
            $0.height.equalTo(1)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(firstSeparator).offset(20)
            $0.bottom.equalTo(secondSeparator).offset(-10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(20)
        }
        
        secondSeparator.snp.makeConstraints {
            $0.bottom.equalTo(commentImageView.snp.top).offset(-10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self)
            $0.height.equalTo(1)
        }
        
        commentImageView.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.bottom.equalTo(thirdSeparator).offset(-10)
            $0.width.equalTo(25)
            $0.height.equalTo(20)
        }
        
        amountCommentLabel.snp.makeConstraints {
            $0.leading.equalTo(commentImageView.snp.trailing).offset(8)
            $0.bottom.equalTo(commentImageView)
            $0.height.equalTo(commentImageView)
        }
        
        
        thirdSeparator.snp.makeConstraints {
            $0.bottom.equalTo(self)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self)
            $0.height.equalTo(1)
        }
    }
}
