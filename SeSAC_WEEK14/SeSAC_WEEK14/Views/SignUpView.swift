//
//  SignUpView.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import Foundation
import UIKit


class SignUpView: UIView, ViewRepresentable {
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let emailTextField = UITextField()
    let applyButton = UIButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        
        addSubview(emailTextField)
        emailTextField.backgroundColor = .white
        
        addSubview(applyButton)
        applyButton.backgroundColor = .orange
        applyButton.setTitle("가입", for: .normal)
    }
    
    func setupConstraints() {
        
        usernameTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        applyButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
    }
    

    
}
