//
//  UpdateCommentViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/06.
//

import Foundation

class UpdateCommentViewModel {
    
    var text: Observable<String> = Observable("")
    
    func updateComment(postId: Int, commentId: Int, completion: @escaping (InsertComment?, Bool) -> Void) {
        if text.value != "" {
            
            CommentManager.updateComment(text: text.value, postId: postId, commentId: commentId) { comentData, error in
                guard let comentData = comentData else {
                    completion(nil, false)
                    return
                }
                print("updateComment: \(self.text.value)")
                completion(comentData, true)
            }
        } else {
            completion(nil, false)
        }
    }
}
