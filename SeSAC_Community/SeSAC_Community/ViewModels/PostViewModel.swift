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
            print("PostViewModel \(postData)")
            print("PostViewModel: \(error)")
        }
    }
}
