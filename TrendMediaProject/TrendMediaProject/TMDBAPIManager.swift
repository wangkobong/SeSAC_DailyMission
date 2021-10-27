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

    func fetchTrendingData(result: @escaping (Int, JSON) -> ()) {
        let key = Bundle.main.TMDBKey
        let url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(key)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["results"].arrayValue {
                    let code = response.response?.statusCode ?? 500
        
                    result(code, json)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

