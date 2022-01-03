//
//  AuthManager.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import Foundation

enum APIError: String, Error {
    case invalidResponse
    case noData
    case failed
    case invalidData = "유효하지 않은 데이터"
}


class AuthManager {
    
    //    public var isSignedIn: Bool {
    //        return
    //    }
        
    
    static func register(userName: String, password: String, userEmail: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: EndPoint.signUp.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(userName)&password=\(password)&email=\(userEmail)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: EndPoint.signIn.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    
    static func changePassword(currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (Authentication?, APIError?) -> Void) {

        var request = URLRequest(url: EndPoint.changePassword.url)
        let token = UserDefaults.standard.string(forKey: "token")!
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    

}

