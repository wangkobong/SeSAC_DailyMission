//
//  InsertBoardViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/05.
//

import Foundation

class InsertBoardViewModel {
    
    var text: Observable<String> = Observable("")
    
    func insertComment(completion: @escaping (InsertPost?, Bool) -> Void) {
        if text.value != "" {
            PostManager.insertPost(text: text.value) { post, error in

                guard let post = post else {
                    print("post데이터 없음")
                    completion(nil, false)
                    return
                }
                completion(post, true)
            }
        } else {
            completion(nil, false)
        }
    }
    
}
