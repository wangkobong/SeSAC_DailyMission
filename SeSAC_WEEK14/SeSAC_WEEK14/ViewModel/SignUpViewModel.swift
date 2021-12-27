//
//  SignUpViewModel.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import Foundation

class SignUpViewModel {
    
    var userName: Observabel<String> = Observabel("")
    var password: Observabel<String> = Observabel("")
    var userEmail: Observabel<String> = Observabel("")
 
    func registerUser(completion: @escaping () -> Void) {
            print(#function)
        APIService.register(userName: userName.value, password: password.value, userEmail: userEmail.value) { userData, error in
            
            guard let userData = userData else {
                print("userData 없음")
                print(error)
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
    
