//
//  PostManager.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import Foundation

class PostManager {
    
    static func getPosts(completion: @escaping (Post?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.boards.url)
        let token = UserDefaults.standard.string(forKey: "token")!
        print("token: \(token)")
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")

        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    
    static func getPost(completion: @escaping (Post?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.boards.url)
        let token = UserDefaults.standard.string(forKey: "token")!
        print("token: \(token)")
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")

        URLSession.request(.shared, endpoint: request, completion: completion)
    }
}
