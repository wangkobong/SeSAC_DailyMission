//
//  TMDBAPIManager.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/27.
//

import UIKit
import Alamofire
import SwiftyJSON

class TMDBAPIManger {
    
    static let shared = TMDBAPIManger()
    
    var movieIDList: [Int] = []

    func fetchTrendingData(result: @escaping (Int, JSON) -> ()) {
        let key = Bundle.main.TMDBKey
        let url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(key)&display=10&start=1"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for _ in json["results"].arrayValue {
                    let code = response.response?.statusCode ?? 500
        
                    result(code, json)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieID(result: @escaping ([Int]) -> ()) {
        let key = Bundle.main.TMDBKey
        let url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(key)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.movieIDList = json["results"].arrayValue.map{ $0["id"].intValue}
                result(self.movieIDList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCreditsData(_ movieID: Int, result: @escaping (JSON) -> ()) {
        let key = Bundle.main.TMDBKey
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(key)&language=en-US"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                result(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}

