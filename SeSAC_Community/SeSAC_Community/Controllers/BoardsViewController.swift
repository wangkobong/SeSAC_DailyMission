//
//  BoardsViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import UIKit

class BoardsViewController: UIViewController {
    
    private let boardsView = BoardsView()
    
    override func loadView() {
        self.view = boardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        boardsView.tableView.delegate = self
        boardsView.tableView.dataSource = self
        title = "새싹농장"
    }
    
}

extension BoardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boardsView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }

}
