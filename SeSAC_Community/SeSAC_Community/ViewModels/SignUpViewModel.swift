//
//  SignUpViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit

class SignUpViewModel {
    
    var userName: Observable<String> = Observable("")
    var userEmail: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var checkPassword: Observable<String> = Observable("")
    


    func registerUser(completion: @escaping (Bool) -> Void) {
        print(#function)
        let testValidation = [userName.value, userEmail.value, password.value, checkPassword.value].filter {
            $0 == ""
        }
        
        if password.value == checkPassword.value {
            AuthManager.register(userName: userName.value, password: password.value, userEmail: userEmail.value) { userData, error in
                
                guard let userData = userData else {
                    completion(false)
                    return
                }
                print("SignUpViewModel: \(userData)")
                
                UserDefaults.standard.set(userData.jwt, forKey: "token")
                UserDefaults.standard.set(userData.user.username, forKey: "nickname")
                UserDefaults.standard.set(userData.user.id, forKey: "id")
                UserDefaults.standard.set(userData.user.email, forKey: "email")
                
                completion(true)

            }
        } else if !testValidation.isEmpty {
            completion(false)
        } else {
            completion(false)
        }

    }
}
