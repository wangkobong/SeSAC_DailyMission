//
//  ViewController.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import UIKit

class SignViewController: UIViewController {
    
    let mainView = SignInView()
    let viewModel = SignInViewModel()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.username.bind { text in
            self.mainView.usernameTextField.text = text
            print(text)
        }
        
        viewModel.password.bind { password in
            self.mainView.passwordTextField.text = password
        }
        
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        mainView.singInButton.addTarget(self, action: #selector(singInButtonClicked), for: .touchUpInside)
    }
    
    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func singInButtonClicked() {
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = MainViewController()
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }

}

