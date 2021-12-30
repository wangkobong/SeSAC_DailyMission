//
//  APIService.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import Foundation

enum APIError: String, Error {
    case invalidResponse
    case noData
    case failed
    case invalidData = "유효하지 않은 데이터"
    
}

class APIService {
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
//        let url = URL(string: "http://test.monocoding.com/auth/local")!
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = Method.POST.rawValue
        // string -> data, dictionary -> JSONSerialization / Codable
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    
    static func register(userName: String, password: String, userEmail: String, completion: @escaping (User?, APIError?) -> Void) {
        
        let url = URL(string: "http://test.monocoding.com/auth/local/register")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(userName)&password=\(password)&email=\(userEmail)".data(using: .utf8, allowLossyConversion: false)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data: \(data)")
            print("response: \(response)")
            print("error: \(error)")
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
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
                print(userData)
            } catch {
                completion(nil, .invalidData)
                print("캐치성공")
            }

        }.resume()
        
    }
    
    static func lotto(_ number: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
        let request = URLRequest(url: url)

        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func person(_ text: String, page: Int, completion: @escaping (Actor?, APIError?) -> Void) {
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        let key = "1d58e1b463506e61588d4b93565a4f73"
        let language = "ko-KR"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: language)
        ]

        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Actor.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
    
            }
        }.resume()

    }
}
