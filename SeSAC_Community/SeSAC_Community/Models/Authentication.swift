//
//  Authentication.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/03.
//


import Foundation

// MARK: - Post
struct Authentication: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



