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
    case getComments
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
        case .getComments:
            return .makeEndPoint("comments")
        case .insertComment:
            return .makeEndPoint("comments")
        case .deleteComment(let id):
            return .makeEndPoint("comments\(id)")
        }
    }
}


extension URL {
    static let baseURL = "http://test.monocoding.com:1231"
    
    static func makeEndPoint(_ endPoint: String) -> URL {
        return URL(string: baseURL + endPoint)!
    }
}
