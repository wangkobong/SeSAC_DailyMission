//
//  SignInView.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit

class SignInView: UIView {

    let nicknameField: UITextField = {
        let field = UITextField()
        field.keyboardType = .namePhonePad
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "닉네임"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()

    let passwordField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "비밀번호"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()


   let signInButton: UIButton = {
        let button = UIButton()
       button.backgroundColor = .systemGray2
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
        
        [nicknameField, passwordField, signInButton].forEach {
            addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        
        nicknameField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
  
    }

}
