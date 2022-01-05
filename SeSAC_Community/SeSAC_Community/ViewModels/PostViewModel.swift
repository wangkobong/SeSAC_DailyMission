//
//  PostViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import Foundation

class PostViewModel {
    
    func getAllPosts(completion: @escaping (Post?) -> Void) {
        print(#function)
        PostManager.getPosts { postData, error in
            completion(postData)
        }
    }
    
    func deletePost(boardId: Int, completion: @escaping (Bool) -> Void) {
        print(#function)
        PostManager.deletePost(boardId: boardId) { deletedData, error in
            
            guard deletedData != nil else {
                print("deletedData: \(String(describing: deletedData))")
                completion(false)
                return
            }

            completion(true)
        }
    }
}
