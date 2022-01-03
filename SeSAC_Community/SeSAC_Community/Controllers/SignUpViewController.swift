//
//  SignUpViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private let signUpViewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = signUpView
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        signUpViewModel.userName.bind { text in
            self.signUpView.nicknameField.text = text
        }
        
        signUpViewModel.userEmail.bind { text in
            self.signUpView.emailField.text = text
        }
        
        signUpViewModel.password.bind { text in
            self.signUpView.passwordField.text = text
        }
        
        signUpViewModel.checkPassword.bind { text in
            self.signUpView.doubleCheckPasswordField.text = text
        }
        
        signUpView.signUpButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        signUpView.nicknameField.addTarget(self, action: #selector(userNameTextFieldDidChange(_:)), for: .editingChanged)

        signUpView.passwordField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        signUpView.doubleCheckPasswordField.addTarget(self, action: #selector(checkPasswordTextFieldDidChange(_:)), for: .editingChanged)

        signUpView.emailField.addTarget(self, action: #selector(userEMailTextFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func userNameTextFieldDidChange(_ textfield: UITextField) {
        signUpViewModel.userName.value = textfield.text ?? ""
    }

    @objc private func passwordTextFieldDidChange(_ textfield: UITextField) {
        signUpViewModel.password.value = textfield.text ?? ""
    }
    
    @objc private func checkPasswordTextFieldDidChange(_ textfield: UITextField) {
        signUpViewModel.checkPassword.value = textfield.text ?? ""
    }

    @objc func userEMailTextFieldDidChange(_ textfield: UITextField) {
        signUpViewModel.userEmail.value = textfield.text ?? ""
    }
    
    
    @objc private func didTapRegister() {
        signUpViewModel.registerUser { success in
            if success {
                DispatchQueue.main.async {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    let vc = UINavigationController(rootViewController: BoardsViewController())
                    windowScene.windows.first?.rootViewController = vc
                    windowScene.windows.first?.makeKeyAndVisible()
                }
            } else {
                self.view.makeToast("정확한 정보를 입력해주세요", duration: 2.0, position: .center, title: "회원가입 실패", image: nil)
            }
        }
    }
}
