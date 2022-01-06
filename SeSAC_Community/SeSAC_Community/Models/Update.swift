//
//  Update.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/06.
//


import Foundation

// MARK: - Update
struct Update: Codable {
    let id: Int
    let text: String
    let user: User7
    let createdAt, updatedAt: String
    let comments: [Comment7]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: - Comment
struct Comment7: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
struct User7: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: JSONNull?
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Encode/decode helpers
