//
//  ActorViewController.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/28.
//

import UIKit
import SnapKit

class ActorViewController: UIViewController {
    
    private var actorViewModel = ActorViewModel()
    
    fileprivate var tableView = UITableView()
    fileprivate var searchBar = UISearchBar()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        searchBar.delegate = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        actorViewModel.actor.bind { person in
            self.tableView.reloadData()
        }
    }
}

extension ActorViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {z
        self.actorViewModel.fetchActor(query: searchBar.text!, page: 1)
    }
}

extension ActorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = actorViewModel.cellForRowAt(at: indexPath)
        cell.textLabel?.text = "\(data.name) | \(data.knownForDepartment)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorViewModel.numberOfRowInSection
        
    }
    
}
