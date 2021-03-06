//
//  SignInViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit
import Toast

class SignInViewController: UIViewController {
    
    private let signInView = SignInView()
    private let signInViewModel = SignInViewModel()
    
    deinit {
        print("\(self) deinit")
    }
    
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
        signInViewModel.postUserLogin { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    let vc = UINavigationController(rootViewController: BoardsViewController())
                    windowScene.windows.first?.rootViewController = vc
                    windowScene.windows.first?.makeKeyAndVisible()

                }
            } else {
                self?.view.makeToast("????????? ?????? ??????????????? ??????????????????!", duration: 2.0, position: .center, title: "????????? ??????", image: nil)
            }
        }
    }
    
}
