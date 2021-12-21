//
//  ViewController.swift
//  SearchTVShows
//
//  Created by sungyeon kim on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let memberName = ["효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린"]
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        
        return searchController
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .white
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 30 - 8) / 3, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .yellow
        
//        searchController.obscuresBackgroundDuringPresentation = false
//        
//        searchController.searchBar.becomeFirstResponder()
//
//        self.navigationItem.titleView = searchController.searchBar
        
        [collectionView].forEach {
            view.addSubview($0)
        }
        
//        searchBar.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    
}

