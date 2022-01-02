//
//  SignInViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let signInView = SignInView()
    private let signInViewModel = SignInViewModel()
    
    override func loadView() {
        self.view = signInView

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        signInViewModel.email.bind { text in
            self.signInView.emailField.text = text
        }
        
        signInViewModel.password.bind { text in
            self.signInView.passwordField.text = text
        }
        
        signInView.emailField.addTarget(self, action: #selector(emailTextFiledDidChange(_:)), for: .editingChanged)
        
        signInView.passwordField.addTarget(self, action: #selector(passwordTextFiledDidChange(_:)), for: .editingChanged)
        
        signInView.signInButton.addTarget(self, action: #selector(didTabSignIn), for: .touchUpInside)
    }
    
    @objc private func emailTextFiledDidChange(_ textfield: UITextField) {
        signInViewModel.email.value = textfield.text ?? ""
    }
    
    @objc private func passwordTextFiledDidChange(_ textfield: UITextField) {
        signInViewModel.password.value = textfield.text ?? ""
    }
    
    @objc private func didTabSignIn() {
        print(#function)
        signInViewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = BoardsViewController()
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
}
