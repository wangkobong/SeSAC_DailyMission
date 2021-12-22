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
    
    let searchBar = UISearchBar()
    
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
        
        configureUI()

    }
    
    func configureUI() {

        collectionView.backgroundColor = .black
        title = "영화 및 TV프로그램"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.tintColor = .white
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.reuseIdentifier)
        
        collectionView.register(HeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader ,withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
      
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
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure()
        return header
    }
    
}


extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchButton Clicked")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function)
    }
}
