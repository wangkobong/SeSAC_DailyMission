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
        changePasswordViewModel.changePassword { [weak self] success in
            if success {
                self?.view.makeToast("???????????? ????????????")
                self?.dismiss(animated: true, completion: nil)
            } else {
                self?.view.makeToast("????????? ????????? ?????? ??? ?????? ??????????????????.", duration: 2.0, position: .center, title: "???????????? ?????? ??????", image: nil)
            }
        }
    }
    
}
