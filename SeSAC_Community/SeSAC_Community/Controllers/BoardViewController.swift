//
//  BoardViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//

import UIKit

class BoardViewController: UIViewController {

    var post: [PostElement] = []
    var postId: Int = 0
    
    private let boardView = BoardView()
//    private let header = BoardHeaderView()
//    private let getPostViewModel = GetPostViewModel()
//
    override func loadView() {
        self.view = boardView
//        print("postId: \(postId)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        boardView.tableView.delegate = self
        boardView.tableView.dataSource = self
//        boardView.tableView.tableHeaderView = header
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "비밀번호 변경", style: .done, target: self, action: #selector(didTabChangePassword))

    }

    
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post[0].comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as? BoardTableViewCell else {
            fatalError()
        }
        if !post[0].comments.isEmpty {
            cell.userNameLabel.text = "\(post[0].comments[indexPath.row].id)"
            cell.textView.text = post[0].comments[indexPath.row].comment
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }


}
