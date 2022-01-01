//
//  ViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2021/12/31.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        homeView.startButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        homeView.loginButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc private func didTapSignUp() {
        print(#function)
        let vc = SignUpViewController()
        vc.title = "새싹농장 가입하기"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSignIn() {
        print(#function)
        let vc = SignInViewController()
        vc.title = "로그인 하기"
        navigationController?.pushViewController(vc, animated: true)
    }
}

