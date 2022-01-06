//
//  UpdatePostViewModel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/05.
//

import Foundation

class UpdatePostViewModel {
    
    var text2: Observable<String> = Observable("")
    
    func updatePost(boardId: Int, completion: @escaping (Update?, Bool) -> Void) {
        print("UpdatePostViewModel text: \(text2.value)")
        if text2.value != "" {
 
            PostManager.updatePost(text: text2.value, boardId: boardId) { postData, error in
                print(#function)
                guard let postData = postData else {
                    completion(nil, false)
                    print("error: \(error)")
                    return
                }
                print("updatePost text: \(self.text2.value)")
                print("UpdatePostViewModel postData: \(postData)")
                completion(postData, true)
            }
        } else {
            print("UpdatePostViewModel 에서 postmanger 호출 안됨")
            completion(nil, false)
        }

    }
}
