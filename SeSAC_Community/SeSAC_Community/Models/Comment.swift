//
//  Comment.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/04.
//

import Foundation

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user: User2
    let post: Post2
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Post
struct Post2: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
struct User2: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

