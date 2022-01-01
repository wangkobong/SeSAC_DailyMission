//
//  SignUpViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit

class SignUpViewModel {
    
    var userName: Observabel<String> = Observabel("")
    var password: Observabel<String> = Observabel("")
    var userEmail: Observabel<String> = Observabel("")
    
    func registerUser(completion: @escaping () -> Void) {
        
    }
}
