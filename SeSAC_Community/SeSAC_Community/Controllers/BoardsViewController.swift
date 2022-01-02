//
//  BoardsViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import UIKit

class BoardsViewController: UIViewController {
    
    var posts: [PostElement] = []
    
    private let boardsView = BoardsView()
    private let postsViewModel = PostViewModel()
    
    override func loadView() {
        self.view = boardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        boardsView.tableView.delegate = self
        boardsView.tableView.dataSource = self
        title = "새싹농장"
        DispatchQueue.main.async {
            self.postsViewModel.getAllPosts { postData in
                postData?.forEach {
                    self.posts.append($0)
                }
                print("post: \(self.posts)")
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            self.boardsView.tableView.reloadData()
        }
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
        print(posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

}
