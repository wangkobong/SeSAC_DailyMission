//
//  EndPoint.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum EndPoint {
    case signUp
    case signIn
    case changePassword
    case insertBoard
    case boards
//    case boardDetail(id: Int)
    case updateBoard(id: Int)
    case deleteBoard(id: Int)
    case getComments(id: Int)
    case insertComment
    case deleteComment(id: Int)
}

extension EndPoint {
    var url: URL {
        switch self {
        case .signUp:
            return .makeEndPoint("auth/local/register")
        case .signIn:
            return .makeEndPoint("auth/local")
        case .changePassword:
            return .makeEndPoint("custom/change-password")
        case .insertBoard:
            return .makeEndPoint("posts")
        case .boards:
            return .makeEndPoint("posts")
        case .updateBoard(let id):
            return .makeEndPoint("posts/\(id)")
        case .deleteBoard(let id):
            return .makeEndPoint("posts/\(id)")
        case .getComments(let id):
            return .makeEndPoint("comments?post=\(id)")
        case .insertComment:
            return .makeEndPoint("comments")
        case .deleteComment(let id):
            return .makeEndPoint("comments\(id)")
        }
    }
}


extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndPoint(_ endPoint: String) -> URL {
        return URL(string: baseURL + endPoint)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable> (_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
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
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
    
            }
        }
    }
}
