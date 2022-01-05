//
//  InsertBoardView.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/05.
//

import UIKit
import SnapKit

class InsertBoardView: UIView {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.textAlignment = .left
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 4
        textView.layer.masksToBounds = true
        textView.text = "코로나로 인해서 일자리도 많이 줄고 취업하기도 어렵구 씁쓸하네요오"
        return textView
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
        
        [textView].forEach {
            addSubview($0)
        }
        
    }
    
    internal func setupConstraints() {
        textView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
    }
}
