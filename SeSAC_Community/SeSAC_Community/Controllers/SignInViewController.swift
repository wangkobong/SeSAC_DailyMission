//
//  SignInViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let signInView = SignInView()
    
    override func loadView() {
        self.view = signInView
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
    
}
