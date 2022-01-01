//
//  SignUpViewController.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    let signUpViewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpViewModel.userName.bind { text in
            self.signUpView.usernameTextField.text = text
        }
        
        signUpViewModel.password.bind { text in
            self.signUpView.passwordTextField.text = text
        }
          
        signUpViewModel.userEmail.bind { text in
            self.signUpView.emailTextField.text = text
        }
        
        signUpView.applyButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        
        signUpView.usernameTextField.addTarget(self, action: #selector(userNameTextFieldDidChange(_:)), for: .editingChanged)

        signUpView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange2(_:)), for: .editingChanged)

        signUpView.emailTextField.addTarget(self, action: #selector(userEMailTextFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func userNameTextFieldDidChange(_ textfield: UITextField) {
        signUpViewModel.userName.value = textfield.text ?? ""
    }

    @objc func passwordTextFieldDidChange2(_ textfield: UITextField) {
        signUpViewModel.password.value = textfield.text ?? ""
    }

    @objc func userEMailTextFieldDidChange(_ textfield: UITextField) {
        signUpViewModel.userEmail.value = textfield.text ?? ""
    }
    
    @objc func registerButtonClicked() {
        print(#function)
        signUpViewModel.registerUser {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = MainViewController()
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }

}
