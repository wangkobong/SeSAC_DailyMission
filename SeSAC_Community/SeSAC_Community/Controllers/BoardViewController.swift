//
//  BoardViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import UIKit
import SnapKit
import Toast

class BoardViewController: UIViewController {

    var post: [PostElement] = []
    var posts: [PostElement] = []
    var postId: Int = 0
    
    private let boardView = BoardView()
    private let insertCommentViewModel = InsertCommentViewModel()
    private let postViewModel = PostViewModel()
    private let BoardsVC = BoardsViewController()
    

    override func loadView() {
        self.view = boardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        boardView.tableView.delegate = self
        boardView.tableView.dataSource = self
        boardView.commentField.delegate = self
        
        insertCommentViewModel.comment.bind { text in
            self.boardView.commentField.text = text
        }
        
        boardView.commentField.addTarget(self, action: #selector(commentTextFieldDidChange), for: .editingChanged)
    }

    
    @objc private func commentTextFieldDidChange(_ textfield: UITextField) {
        insertCommentViewModel.comment.value = textfield.text ?? ""
    }

    
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return post[0].comments.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if indexPath.section == 0 {
            guard let boardCell = tableView.dequeueReusableCell(withIdentifier: BoardHeaderTableViewCell.reuseIdentifier, for: indexPath) as? BoardHeaderTableViewCell else {
                fatalError()
            }
            
            boardCell.userNameLabel.text = "\(post[0].user.username)"
            boardCell.createdAtLabel.text = "\(post[0].updatedAt)"
            boardCell.textView2.text = "\(post[0].text)"
            boardCell.amountCommentLabel.text = "댓글 \(post[0].comments.count)"
            
            return boardCell
        } else if indexPath.section == 1 {
            guard let commentCell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as? BoardTableViewCell else {
                fatalError()
            }
            if !post[0].comments.isEmpty {
                commentCell.userNameLabel.text = "\(post[0].comments[indexPath.row].id)"
                commentCell.textView.text = post[0].comments[indexPath.row].comment
                return commentCell
            }
            return commentCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 230
        } else {
            return 100
        }
    }


}

extension BoardViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        let boardId = post[0].id
        insertCommentViewModel.boardId = boardId
        DispatchQueue.main.async {
            self.insertCommentViewModel.insertComment { comment, success in
            if success {
                self.view.makeToast("성공.", duration: 2.0, position: .center, title: "댓글작성 성공", image: nil)
                let currentPostId = boardId
                self.postViewModel.getAllPosts { post in
                    post?.forEach {
                        self.posts.append($0)
                    }
                    let currentPost = self.posts.filter {
                        $0.id == currentPostId
                    }
                    self.post = currentPost
                    self.boardView.tableView.reloadData()
                    self.boardView.commentField.text = ""
                }

            } else {
                self.view.makeToast("", duration: 2.0, position: .center, title: "댓글작성 실패", image: nil)
                }
            }
     
        }
        return true
    }
}
