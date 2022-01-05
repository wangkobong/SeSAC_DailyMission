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
        
        setRightBarButtonItem()
        
        insertCommentViewModel.comment.bind { text in
            self.boardView.commentField.text = text
        }
        
        boardView.commentField.addTarget(self, action: #selector(commentTextFieldDidChange), for: .editingChanged)

    }

    
    @objc private func commentTextFieldDidChange(_ textfield: UITextField) {
        insertCommentViewModel.comment.value = textfield.text ?? ""
    }
    
    @objc private func didTabRightBarButton() {
        print(#function)
        showActionSheet()
    }
    
    func setRightBarButtonItem() {
        let writerEmail = post[0].user.email
        guard let userEmail = UserDefaults.standard.string(forKey: "email") else { return }
        if writerEmail == userEmail {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(didTabRightBarButton))
        } else {
            return
        }
    }
    
    func showActionSheet() {
        let boardId = postId
        print("boardID: \(boardId)")
        let actionSheet = UIAlertController(title: "선택", message: "뭐할래", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "게시글 수정", style: .default, handler: { result in
            print(result)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "게시글 삭제", style: .destructive, handler: { _ in
            self.postViewModel.deletePost(boardId: boardId) { success in
                if success {
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        let vc = UINavigationController(rootViewController: BoardsViewController())
                        windowScene.windows.first?.rootViewController = vc
                        windowScene.windows.first?.makeKeyAndVisible()

                    }
                } else {
                    self.view.makeToast("다시 시도해주세요!", duration: 2.0, position: .center, title: "게시글 삭제 실패", image: nil)
                }
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func deleteAction() {
        print(#function)
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
