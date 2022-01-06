//
//  InsertCommentViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/04.
//

import Foundation

class InsertCommentViewModel {
    
    var comment: Observable<String> = Observable("")
    var boardId = 0

    func insertComment(completion: @escaping (InsertComment?, Bool) -> Void) {
        if comment.value != "" {
            CommentManager.insertComment(comment: comment.value, postId: boardId) { comment, error in
                guard let comment = comment else {
                    
                    completion(nil, false)
                    return
                }
                print("comment : \(String(describing: comment))")
                
                completion(comment, true)
            }
        } else {
            completion(nil, false)
        }
    }
    
    func getCommentById(completion: @escaping (Comment?, Bool) -> Void) {
        CommentManager.getCommentByBoardId(boardId: boardId) { comment, error in
            guard let comment = comment else {
                
                completion(nil, false)
                return
            }
            
            print("comment : \(String(describing: comment))")
            
            completion(comment, true)
        }
    }
    
}



