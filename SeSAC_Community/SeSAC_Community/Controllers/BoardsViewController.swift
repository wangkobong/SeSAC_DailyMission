//
//  BoardsViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import UIKit

class BoardsViewController: UIViewController {
    
    deinit {
        print("\(self) deinit")
    }
    
    var posts: [PostElement] = []
    var comments: [Comment] = []
    
    private let boardsView = BoardsView()
    private let postsViewModel = PostViewModel()
    private let getCommentsViewModel = GetCommentsViewModel()
    
    override func loadView() {
        self.view = boardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        boardsView.tableView.delegate = self
        boardsView.tableView.dataSource = self
        title = "새싹농장"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "비밀번호 변경", style: .done, target: self, action: #selector(didTabChangePassword))

        boardsView.composeButton.addTarget(self, action: #selector(didTabComposeButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        posts.removeAll()
        DispatchQueue.main.async {
            self.postsViewModel.getAllPosts { [weak self] postData in
                postData?.forEach {
                    self?.posts.append($0)
                }

            }
        }

        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) { [weak self] in
            self?.boardsView.tableView.reloadData()
        }
    }
    
    @objc private func didTabComposeButton() {
        print(#function)
        let vc = InsertBoardViewController()
        vc.title = "게시글 작성"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTabChangePassword() {
        let vc = ChangePasswordViewController()
        vc.title = "비밀번호 변경"
        present(vc, animated: true)
    }
    
}

extension BoardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsTableViewCell.reuseIdentifier, for: indexPath) as? BoardsTableViewCell else {
            fatalError()
        }
        cell.textView.text = posts[indexPath.row].text
        cell.userNameLabel.text = posts[indexPath.row].user.username
        cell.createdAtLabel.text = posts[indexPath.row].createdAt
        if posts[indexPath.row].comments.isEmpty {
            cell.amountCommentLabel.text = "댓글쓰기"
        } else {
            cell.amountCommentLabel.text = "댓글 \(posts[indexPath.row].comments.count)개"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPostId = posts[indexPath.row].id
        
        let currentPost = posts.filter {
            $0.id == currentPostId
        }
        
        let group = DispatchGroup()
        let vc = BoardViewController()
        vc.title = "게시글"
        vc.post = currentPost
        vc.postId = currentPostId
        DispatchQueue.global().async(group: group) { [weak self] in
            group.enter()
            self?.getCommentsViewModel.getComments(boardId: currentPostId) { comments in
                comments?.forEach {
                    vc.currentComments.append($0)
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) { [weak self] in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
