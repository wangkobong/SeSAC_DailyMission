//
//  PostManager.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import Foundation

class PostManager {
    
    static func getPosts(completion: @escaping (Post?, APIError?) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoint.boards.url)
        let token = UserDefaults.standard.string(forKey: "token")!
        print("token: \(token)")
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField:"authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, .failed)
                print("error APIService에서: \(error)")
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .invalidData)
                print("response: \(response)")
                return
            }
            
            guard response.statusCode == 200 else {
                completion(nil, .failed)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(Post.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .invalidData)
                print("캐치성공")
            }

        }.resume()
        
//        URLSession.request(.shared, endpoint: request, completion: completion)
    }
}
