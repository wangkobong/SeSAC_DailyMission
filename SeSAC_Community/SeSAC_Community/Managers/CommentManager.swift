//
//  CommentManager.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/04.
//

import Foundation

class CommentManager {
    
    static func insertComment(comment: String, postId: Int, completion: @escaping (Comment?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.insertComment.url)
        let token = UserDefaults.standard.string(forKey: "token")!
        print("token: \(token)")
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")

        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    
    static func getCommentByBoardId(boardId: Int, completion: @escaping (Comment?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.getComments(id: boardId).url)
        let token = UserDefaults.standard.string(forKey: "token")!

        request.httpMethod = "GET"
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")
        URLSession.request(.shared, endpoint: request, completion: completion)
    }
}
