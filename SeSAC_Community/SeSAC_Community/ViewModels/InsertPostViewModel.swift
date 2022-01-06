//
//  InsertBoardViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/05.
//

import Foundation

class InsertPostViewModel {
    
    var text: Observable<String> = Observable("")
    
    func insertPost(completion: @escaping (InsertPost?, Bool) -> Void) {
        print("InsertPostViewModel text: \(text.value)")
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
