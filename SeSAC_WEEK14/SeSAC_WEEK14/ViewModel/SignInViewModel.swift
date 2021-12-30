//
//  SignInViewModel.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import Foundation

class SignInViewModel {

    var username: Observabel<String> = Observabel("kobong")
    var password: Observabel<String> = Observabel("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        print(#function)
        APIService.login(identifier: username.value, password: password.value) {
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
        username.value = UserDefaults.standard.string(forKey: "nickname") ?? "dd"
    }
    

}
