//
//  APIService.swift
//  SearchTVShows
//
//  Created by sungyeon kim on 2021/12/23.
//

import Foundation

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
    
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class APIService {
    let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day?api_key=1d58e1b463506e61588d4b93565a4f73")!
    
    func requestTVShows(completion: @escaping (TVShows?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.showAlert(.serverError)
                return
            }
            
            if let data = data, let castData = try? JSONDecoder().decode(TVShows.self, from: data) {
                print("SUCCEED", castData)
                completion(castData)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func showAlert(_ msg: APIError) {
        print(msg)
    }
}
