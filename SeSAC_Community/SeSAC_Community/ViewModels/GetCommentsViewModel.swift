//
//  GetPostViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import Foundation

class GetCommentsViewModel {
    
    func getComments(boardId: Int, completion: @escaping (Comment?) -> Void) {
        CommentManager.getCommentByBoardId(boardId: boardId) { comments, error in
            
            guard let comments = comments else {
                print("comments 없음")
                completion(nil)
                return
            }
            completion(comments)
        }
    }
}
