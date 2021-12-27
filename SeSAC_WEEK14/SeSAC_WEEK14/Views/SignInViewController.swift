//
//  ViewController.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import UIKit

class SignViewController: UIViewController {
    
    let signInView = SignInView()
    let signInViewModel = SignInViewModel()
    let signUpViewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = signInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInViewModel.username.bind { text in
            self.signInView.usernameTextField.text = text
            print(text)
        }
        
        signInViewModel.password.bind { password in
            self.signInView.passwordTextField.text = password
        }
        
        signInView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        
        signInView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        signInView.singInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
        signInView.singUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }
    
    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        signInViewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        signInViewModel.password.value = textfield.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        print(#function)
        signInViewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = MainViewController()
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    @objc func signUpButtonClicked() {
        print(#function)
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

}

