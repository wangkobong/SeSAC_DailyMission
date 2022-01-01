//
//  SignUpViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit

class SignUpViewModel {
    
    var userName: Observabel<String> = Observabel("")
    var userEmail: Observabel<String> = Observabel("")
    var password: Observabel<String> = Observabel("")
    var checkPassword: Observabel<String> = Observabel("")

    func registerUser(completion: @escaping () -> Void) {
        print(#function)
//        if password.value == checkPassword.value {
//
//        } else {
//            print("비번확인하셈")
//        }
        AuthManager.register(userName: userName.value, password: password.value, userEmail: userEmail.value) { userData, error in
            
            print(userData)
            print(error)
     
            guard let userData = userData else {
                print("유저데이터없음")
                return
            }
            print("SignUpViewModel: \(userData)")
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()

        }
    }
}
