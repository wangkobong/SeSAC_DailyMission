//
//  ChangePasswordView.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import UIKit
import SnapKit

class ChangePasswordView: UIView {
    
    let currentPasswordField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "현재 비밀번호"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    let newPasswordField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "새로운 비밀번호"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    let doubleCheckPasswordField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "비밀번호 확인"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    let changeButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .systemGreen
         button.setTitle("비밀번호 변경", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.layer.cornerRadius = 8
         button.layer.masksToBounds = true
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
        
        [currentPasswordField ,newPasswordField , doubleCheckPasswordField, changeButton].forEach {
            addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        currentPasswordField.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        newPasswordField.snp.makeConstraints {
            $0.top.equalTo(currentPasswordField.snp.bottom).offset(8)
            $0.centerX.equalTo(currentPasswordField)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        doubleCheckPasswordField.snp.makeConstraints {
            $0.top.equalTo(newPasswordField.snp.bottom).offset(8)
            $0.centerX.equalTo(newPasswordField)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        changeButton.snp.makeConstraints {
            $0.top.equalTo(doubleCheckPasswordField.snp.bottom).offset(8)
            $0.centerX.equalTo(newPasswordField)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
      
    }
}
