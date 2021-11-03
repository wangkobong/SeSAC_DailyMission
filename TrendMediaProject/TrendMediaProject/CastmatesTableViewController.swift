//
//  CastmatesTableViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/17.
//

import UIKit
import Kingfisher

class CastmatesTableViewController: UITableViewController {


    var mediaTitle: String?
    var overview: String?
    var rate: Double?
    var starring: String?
    var backdropImage: String?
    var actorList: [String]?
    var genre: String?
    
    var movieIDList: [Int] = []
    var castData: [CastModel] = []
    
    var startPage = 1
    var totalCount = 0

    
    @IBOutlet var summaryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mediaTitle ?? "내용 없음"
        
//        tableView.prefetchDataSource = self
//        
        summaryCollectionView.delegate = self
        summaryCollectionView.dataSource = self
        
        let nibName = UINib(nibName: SummaryCollectionViewCell.identifier, bundle: nil)
        summaryCollectionView.register(nibName, forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier)
        
        TMDBAPIManger.shared.getMovieID { idList in
            self.movieIDList = idList
            self.tableView.reloadData()
        }

    }
    
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        <#code#>
//    }
//
//

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actorList = starring?.components(separatedBy: ",")
                return actorList?.count ?? 10
        // 받아온 cast배열의 총갯수가 row의 갯수
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastmatesTableViewCell", for: indexPath) as? CastmatesTableViewCell else {
            return UITableViewCell()
        }
        

        
        cell.nameLabel.text = actorList?[indexPath.row]
//        cell.nameLabel.text = castData[indexPath.row].nameData
//        cell.roleLabel.text = castData[indexPath.row].characterData
//        cell.actorImageView.image =
        print(movieIDList)
        return cell
    }

}

// MARK: - SummaryCollectionView
extension CastmatesTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.identifier, for: indexPath) as? SummaryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
 
        let url = URL(string: backdropImage ?? "")
        cell.posterImageView.kf.setImage(with:url)
        cell.titleLabel.text = mediaTitle
        cell.summaryLabel.text = overview

        return cell
    }
    
    
}


