//
//  ChangePasswordViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import UIKit
import Toast

class ChangePasswordViewController: UIViewController {
    
    private let changePasswordView = ChangePasswordView()
    private let changePasswordViewModel = ChangePasswordViewModel()
    
    override func loadView() {
        self.view = changePasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        changePasswordViewModel.currentPassword.bind { text in
            self.changePasswordView.currentPasswordField.text = text
        }
        
        changePasswordViewModel.newPassword.bind { text in
            self.changePasswordView.newPasswordField.text = text
        }
        
        changePasswordViewModel.confirmNewPassword.bind { text in
            self.changePasswordView.doubleCheckPasswordField.text = text
        }
        
        changePasswordView.currentPasswordField.addTarget(self, action: #selector(currentPasswordFieldDidChange(_:)), for: .editingChanged)
        
        changePasswordView.newPasswordField.addTarget(self, action: #selector(newPasswordFieldDidChange(_:)), for: .editingChanged)
        
        changePasswordView.doubleCheckPasswordField.addTarget(self, action: #selector(confirmNewPasswordFieldDidChange(_:)), for: .editingChanged)
        
        changePasswordView.changeButton.addTarget(self, action: #selector(didTapChangePassword), for: .touchUpInside)
    }
    
    @objc private func currentPasswordFieldDidChange(_ textfield: UITextField) {
        changePasswordViewModel.currentPassword.value = textfield.text ?? ""
    }
    
    @objc private func newPasswordFieldDidChange(_ textfield: UITextField) {
        changePasswordViewModel.newPassword.value = textfield.text ?? ""
    }
    
    @objc private func confirmNewPasswordFieldDidChange(_ textfield: UITextField) {
        changePasswordViewModel.confirmNewPassword.value = textfield.text ?? ""
    }
    
    @objc private func didTapChangePassword() {
        changePasswordViewModel.changePassword { success in
            if success {
                self.view.makeToast("비밀번호 변경성공")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.view.makeToast("정확한 정보를 입력 후 다시 시도해주세요.", duration: 2.0, position: .center, title: "비밀번호 변경 실패", image: nil)
            }
        }
    }
    
}
