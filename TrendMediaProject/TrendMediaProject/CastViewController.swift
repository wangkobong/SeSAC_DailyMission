//
//  CastViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/31.
//

import UIKit
import Kingfisher

class CastViewController: UIViewController, UITableViewDataSource {
    /*
     
     name
     profile_path
     character
     */
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var summaryData: [SummaryModel] = []
    var castData: [CastModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchCastData()
    }
    
    func fetchTrendingData() {
        TMDBAPIManger.shared.fetchTrendingData {code, json in
            print(json)

            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let backdropPath = item["backdrop_path"].stringValue
                let data = SummaryModel(titleData: title, backdropPathData: backdropPath)
                self.summaryData.append(data)
            }
             
            self.tableView.reloadData()

        }
    }
    
//    func getId() {
//        TMDBAPIManger.shared.getMovieID { <#[Int]#> in
//            <#code#>
//        }
//    }
    
    func fetchCastData() {
        TMDBAPIManger.shared.fetchCreditsData(796499) { json in
            for item in json["cast"].arrayValue {
                let name = item["name"].stringValue
                let character = item["character"].stringValue
                let profilePath = item["profile_path"].stringValue
                let data = CastModel(nameData: name, backdropPathData: profilePath, characterData: character)
                self.castData.append(data)
            }
            self.tableView.reloadData()
        }
    }

}

extension CastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else {
            return UITableViewCell()
        }
        let row = castData[indexPath.row]
        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+row.backdropPathData)

        cell.nameLabel.text = row.nameData
        cell.characterLabel.text = row.characterData
        cell.profileImageView.kf.setImage(with:url)

        return cell
    }
    
    
}
