//
//  ChangePasswordViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import Foundation

class ChangePasswordViewModel {
    
    var currentPassword: Observable<String> = Observable("")
    var newPassword: Observable<String> = Observable("")
    var confirmNewPassword: Observable<String> = Observable("")
    
    func changePassword(completion: @escaping (Bool) -> Void) {
        if newPassword.value == confirmNewPassword.value {
            AuthManager.changePassword(currentPassword: currentPassword.value, newPassword: newPassword.value, confirmNewPassword: confirmNewPassword.value) { auth, error in
                
                guard let auth = auth else {
                    
                    completion(false)
                    return
                }
                print("auth : \(String(describing: auth))")
                
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
}
