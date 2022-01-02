//
//  BoardsViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import UIKit

class BoardsViewController: UIViewController {
    
    var posts: [Post] = []
    
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
        postsViewModel.getAllPosts { postData in
            print(postData)
        }
    }
    
}

extension BoardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boardsView.tableView.dequeueReusableCell(withIdentifier: BoardsTableViewCell.reuseIdentifier, for: indexPath)
        let maskLayer = CAShapeLayer()
        let bounds = cell.bounds
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 2, y: 2, width: bounds.width-4, height: bounds.height-4), cornerRadius: 5).cgPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

}
