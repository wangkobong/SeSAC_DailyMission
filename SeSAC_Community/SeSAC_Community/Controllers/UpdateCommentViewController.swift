//
//  UpdateCommentViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/06.
//

import UIKit

class UpdateCommentViewController: UIViewController  {
    
    private let updateCommentView = UpdateCommentView()
    private let updateCommentViewModel = UpdateCommentViewModel()
    
    var currentCommentId = 0
    var currentCommentText = ""
    var currentPostId = 0
    
    override func loadView() {
        self.view = updateCommentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "댓글 수정", style: .done, target: self, action: #selector(didTabUpdateComment))
        view.backgroundColor = .systemBackground
        setText()
        
        updateCommentViewModel.text.bind { text in
            self.updateCommentView.textView.text = text
        }
        
        updateCommentView.textView.delegate = self

    }
    
    @objc private func didTabUpdateComment() {
        updateCommentViewModel.updateComment(postId: currentPostId, commentId: currentCommentId) { comment, success in
            
            if success {
                print("수정성공")
            } else {
                print("수정실패")
            }
        }
    }
    
    func setText() {
        updateCommentViewModel.text.value = currentCommentText
    }
    

}


extension UpdateCommentViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        updateCommentViewModel.text.value = textView.text ?? ""
        print("textViewDidChange: \(textView.text)")
    }
}
