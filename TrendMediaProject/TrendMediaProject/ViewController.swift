//
//  ViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/15.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    
    @IBOutlet weak var tableView: UITableView!
    
    var mediaInformation = MediaInformation()
    var trendData: [TrendModel] = []
    
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData() 
    }

    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        //        nav.modalTransitionStyle = .flipHorizontal
        self.present(nav, animated: true, completion: nil)


    }
    @IBAction func bookButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookCollectionViewController") as! BookCollectionViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        //        nav.modalTransitionStyle = .flipHorizontal
        self.present(nav, animated: true, completion: nil)

    }
    
    
    @IBAction func pinButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TheaterLocationViewController") as! TheaterLocationViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        //        nav.modalTransitionStyle = .flipHorizontal
        self.present(nav, animated: true, completion: nil)
    }
/// MARK: - delegate mothods
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if trendData.count - 1 == indexPath.row && trendData.count < totalCount {
                startPage += 10
                loadData()
                print("prefetch: \(indexPath)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mediaInformation.tvShow.count
        return trendData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else {
            return UITableViewCell()
        }
        


        let row = trendData[indexPath.row]
        let title = row.titleData
        if title != "" {
            cell.titleTextLabel.text = row.titleData
        } else {
            cell.titleTextLabel.text = "정보 없음"
        }
        

        cell.overviewLabel.text = row.overviewData
        cell.overviewLabel.numberOfLines = 0
        cell.rateLabel.text = row.voteAverageData
        cell.rateLabel.textColor = .black
        cell.genreTextLabel.text = row.mediaTypeData
        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+row.backdropPathData)
        cell.releaseDateLabel.text = row.releaseDateData
        
        cell.clipbutton.layer.cornerRadius = 0.5 * cell.clipbutton.bounds.size.width
        cell.clipbutton.clipsToBounds = true

        cell.posterImageView.kf.setImage(with:url)
        cell.posterImageView.contentMode = .scaleToFill

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
 

        guard let vc = sb.instantiateViewController(withIdentifier: "CastViewController") as? CastViewController else {
            print("ERROR") // 대신에 Alert으로 사용자에게 에러를 보여줌
            return
        }
        
        loadData()
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func clupButtonPressed(_ sender: UIButton) {
        print(sender)
    }
    
    func loadData() {
        TMDBAPIManger.shared.fetchTrendingData { code, json in
            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let backdropImage = item["backdrop_path"].stringValue
                let overview = item["overview"].stringValue
                let voteAverage = item["vote_average"].stringValue
                let releaseDate = item["release_date"].stringValue
                let mediaType = item["media_type"].stringValue
                let data = TrendModel(titleData: title, backdropPathData: backdropImage, overviewData: overview, voteAverageData: voteAverage, releaseDateData: releaseDate, mediaTypeData: mediaType)
                self.trendData.append(data)
            }
            
            self.tableView.reloadData()
        }
    }

    
}

