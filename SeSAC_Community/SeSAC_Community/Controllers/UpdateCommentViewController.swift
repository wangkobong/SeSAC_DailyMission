//
//  UpdateCommentViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/06.
//

import UIKit
import Toast

protocol UpdateCommentDelegate {
    func updateComment(comment: Comment)
}

class UpdateCommentViewController: UIViewController  {
    
    var delegate: UpdateCommentDelegate?
    
    private let updateCommentView = UpdateCommentView()
    private let updateCommentViewModel = UpdateCommentViewModel()
    private let getCommentsViewModel = GetCommentsViewModel()
    private let boardView = BoardView()
    
    var currentCommentId = 0
    var currentCommentText = ""
    var currentPostId = 0
    var currentComments: Comment = []
    
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
                self.getCommentsViewModel.getComments(boardId: self.currentPostId) { comments in

                    DispatchQueue.main.async {
                        guard let comments = comments else {
                            return
                        }

                        self.currentComments = comments
                        self.delegate?.updateComment(comment: self.currentComments)
                    }
                }
                self.navigationController?.popViewController(animated: true)
            } else {
                self.view.makeToast("내용을 입력해주세요", duration: 2.0, position: .center, title: "댓글 수정 실패", image: nil)
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
    }
}
