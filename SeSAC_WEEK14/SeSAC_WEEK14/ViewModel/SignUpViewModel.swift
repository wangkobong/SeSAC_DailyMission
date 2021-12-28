//
//  SignUpViewModel.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import Foundation
import UIKit

class SignUpViewModel {
    
    var userName: Observabel<String> = Observabel("")
    var password: Observabel<String> = Observabel("")
    var userEmail: Observabel<String> = Observabel("")
    let alert = UIAlertController(title: "회원가입에 실패했습니다.", message: "왜인지는 몰라", preferredStyle: UIAlertController.Style.alert)
    let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler : nil)

    func registerUser(completion: @escaping () -> Void) {
            print(#function)
        APIService.register(userName: userName.value, password: password.value, userEmail: userEmail.value) { userData, error in
            
            guard let userData = userData else {
                print("userData 없음")
                print("뷰모델에서 에러: \(error)")

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
    
