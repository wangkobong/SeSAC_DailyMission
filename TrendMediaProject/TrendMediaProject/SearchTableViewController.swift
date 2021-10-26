//
//  SearchTableViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/17.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class SearchTableViewController: UITableViewController {
    
    var movieData: [MovieModel] = []
    
    var mediaInformation = MediaInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonPressed))
        
        fetchMovieData()
    }
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData() {
        //네이버 영화 API 호출해서 debug 결과 찍기
        
        if let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1&"
            let clientID = Bundle.main.clientID
            let clientSecret = Bundle.main.clientSecret
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": clientID,
                "X-Naver-Client-Secret": clientSecret
            ]

            AF.request(url, method: .get ,headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let firstTitle = json["items"][0]["title"].stringValue
                    
                    for item in json["items"].arrayValue {
                        let title = item ["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let subtitle = item["subtitle"].stringValue
                        let pubDate = item["pubDate"].stringValue
                        let data = MovieModel(titleData: title, imageData: image, linkData: link, UserRatingData: userRating, subtitle: subtitle, pubDateData: pubDate)
                        
                        self.movieData.append(data)
                    }
                    
                    //정말 중요함!
                    self.tableView.reloadData()
                    print(self.movieData)
                    print("첫번쨏: \(firstTitle)")
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            return
        }

    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = movieData[indexPath.row]
        let url = URL(string: row.imageData)
        
        cell.posterImage.kf.setImage(with:url)
//        cell.mediaTitleLabel.text = row.title
        cell.mediaTitleLabel.text = row.titleData
        cell.releaseDateLabel.text = row.pubDateData
//        cell.overviewLabel.text = row.overview
//        cell.overviewLabel.numberOfLines = 0
//        cell.regionLabel.text = row.region
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }


}
