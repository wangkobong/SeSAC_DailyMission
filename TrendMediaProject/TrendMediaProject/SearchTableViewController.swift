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

class SearchTableViewController: UITableViewController, UITableViewDataSourcePrefetching {

    
    var movieData: [MovieModel] = []
    var mediaInformation = MediaInformation()
    @IBOutlet weak var searchBar: UISearchBar!
    
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonPressed))
        
        fetchMovieData(query: "아기")
    }
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData(query: String) {
        //네이버 영화 API 호출해서 debug 결과 찍기
        
        if let query1 = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query1)&display=10&start=\(startPage)&"
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
                    
                    self.totalCount = json["total"].intValue
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
    
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                fetchMovieData(query: "아기")
                print("prefetch: \(indexPath)")
            }
        }
    }
    
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소:\(indexPaths)")
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

extension SearchTableViewController: UISearchBarDelegate {
    
    
    // 취소 버튼 눌렀을 떄 실행

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        

        
    }
    // 검색 버튼 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.showsCancelButton = false
        if let text = searchBar.text {
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: text)
        }
    }
    
    // 서치바에 커서 깜빡이기 시작할떄
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
}
