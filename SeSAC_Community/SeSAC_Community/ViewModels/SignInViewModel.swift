//
//  SignInViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import Foundation

class SignInViewModel {

    var email: Observabel<String> = Observabel("")
    var password: Observabel<String> = Observabel("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        print(#function)
        AuthManager.login(identifier: email.value, password: password.value) {
            userData, error in
            
            guard let userData = userData else {
                return
            }
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
        }
    }
    
    func getUserName() {
        email.value = UserDefaults.standard.string(forKey: "email") ?? "dd"
    }
}
