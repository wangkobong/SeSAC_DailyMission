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
    var currentComments: Comment = []

    
    private let boardView = BoardView()
    private let boardTableViewCell = BoardTableViewCell()
    private let insertCommentViewModel = InsertCommentViewModel()
    private let postViewModel = PostViewModel()
    private let getCommentsViewModel = GetCommentsViewModel()
    private let updateCommentViewModel = UpdateCommentViewModel()
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
        let group = DispatchGroup()
        DispatchQueue.global().async(group: group) {
            group.enter()
            self.getComments()
        }
       

        
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
        showActionSheetForPost()
    }
    
    @objc private func didTabLineButton(sender: UIButton) {
        print(#function)
        let commentId = sender.tag
        showActionSheetForComment(currentCommentId: commentId)
    }
    

    
    func getComments() {
        self.getCommentsViewModel.getComments(boardId: self.postId) { comments in
            
            comments?.forEach {
                self.currentComments.append($0)
            }

        }
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
    
    func showActionSheetForPost() {
        let boardId = postId
        print("boardID: \(boardId)")
        let actionSheet = UIAlertController(title: "선택", message: "뭐할래", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "게시글 수정", style: .default, handler: { _ in
            let vc = InsertBoardViewController()
            vc.title = "게시글 수정"
            vc.isInsert = false
            vc.currentPost = self.post
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    func showActionSheetForComment(currentCommentId: Int) {
        let actionSheet = UIAlertController(title: "원하시는 메뉴를 선택해주세요", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "댓글 수정", style: .default, handler: { _ in
            let vc = UpdateCommentViewController()
            vc.delegate = self
            vc.currentCommentId = currentCommentId
            vc.currentPostId = self.post[0].id
            let currentComment = self.currentComments.filter{ $0.id == currentCommentId }
            vc.currentCommentText = currentComment[0].comment
            vc.title = "댓글 수정"

            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "댓글 삭제", style: .destructive, handler: { _ in
  
            self.updateCommentViewModel.deleteComment(commentId: currentCommentId) { deletedCommentData, success in
                if success {
 
                    self.view.makeToast("성공!", duration: 2.0, position: .center, title: "댓글 삭제 성공", image: nil)
                    self.getCommentsViewModel.getComments(boardId: self.post[0].id) { comments in
                        DispatchQueue.main.async {

                            self.currentComments = comments!

                            self.boardView.tableView.reloadData()
                        }
                    }
                } else {
                    self.view.makeToast("다시 시도해주세요!", duration: 2.0, position: .center, title: "댓글 삭제 실패", image: nil)
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

            return self.currentComments.count
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
            if !currentComments.isEmpty {

                commentCell.userNameLabel.text = "\(currentComments[indexPath.row].user.username)"
                commentCell.textView.text = currentComments[indexPath.row].comment
                let myEmail = UserDefaults.standard.string(forKey: "email") ?? ""
                if currentComments[indexPath.row].user.email != myEmail {
                    commentCell.lineButton.layer.isHidden = true
                } else {
                    let commentId = currentComments[indexPath.row].id
                    commentCell.lineButton.layer.isHidden = false
                    commentCell.lineButton.tag = commentId
                    commentCell.lineButton.addTarget(self, action: #selector(didTabLineButton(sender:)), for: .touchUpInside)
                }
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
                self.currentComments.removeAll()
                self.getCommentsViewModel.getComments(boardId: currentPostId) { comments in
                    DispatchQueue.main.async {
                        print("댓글삭제후 남은 댓글불러오기: \(comments)")
                        self.currentComments = comments!
                        print("댓글삭제후 남은 댓글불러와서 다른데 넣기: \(self.currentComments)")

                        self.boardView.tableView.reloadData()
                        self.boardView.commentField.text = ""
                    }
                }


            } else {
                self.view.makeToast("", duration: 2.0, position: .center, title: "댓글작성 실패", image: nil)
                }
            }
     
        }
        return true
    }
}


extension BoardViewController: UpdateCommentDelegate {
    func updateComment(comment: Comment) {
        self.currentComments = comment
        self.boardView.tableView.reloadData()
    }
}
