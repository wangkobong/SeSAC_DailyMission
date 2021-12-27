//
//  ViewController.swift
//  SearchTVShows
//
//  Created by sungyeon kim on 2021/12/21.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    let memberName = ["효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린", "효정", "미미", "유아", "승희", "지호", "비니", "아린"]
    
    let searchBar = UISearchBar()

    let apiService = APIService()
    var tvShowsData: TVShows?
    
    var buffer: Data?
    var session: URLSession!
    
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
        apiService.requestTVShows { tvShows in
            print(#function)
            self.tvShowsData = tvShows
            print(tvShows!)
        }
//        request()
        configureUI()
//        buffer = Data()
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
        
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.reuseIdentifier)
        
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
    
//    func request() {
//        let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day?api_key=1d58e1b463506e61588d4b93565a4f73")!
//
//        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
//        session.dataTask(with: url).resume()
//    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tvShowsData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.reuseIdentifier, for: indexPath) as! PosterCollectionViewCell

        let posterPath = tvShowsData?.results[indexPath.row].posterPath
        let url = "https://image.tmdb.org/t/p/w500\(posterPath!)"
        
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let myURL = URL(string: encoded) {
            print(myURL)
            cell.posterImageView.kf.setImage(with: myURL)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure()
        return header
    }
    
}

extension ViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(#function)
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("ERROR: \(error)")
        } else {
            print("성공")
            print("task: \(task)")
            print("data: \(self.buffer)")
        }
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
