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
    
    static func insertPost(text: String, completion: @escaping (InsertPost?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.insertBoard.url)
        let token = UserDefaults.standard.string(forKey: "token")!
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        URLSession.request(.shared, endpoint: request, completion: completion)
        
    }
    
    static func deletePost(boardId: Int, completion: @escaping (InsertPost?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.deleteBoard(id: boardId).url)
        let token = UserDefaults.standard.string(forKey: "token")!
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")
        URLSession.request(.shared, endpoint: request, completion: completion)
        
    }
    
    static func updatePost(text: String, boardId: Int, completion: @escaping (Update?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.updateBoard(id: boardId).url)
        let token = UserDefaults.standard.string(forKey: "token")!
        print("token: \(token)")
        request.httpMethod = Method.PUT.rawValue
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        URLSession.request(.shared, endpoint: request, completion: completion)
        
    }
    

    
    
}
