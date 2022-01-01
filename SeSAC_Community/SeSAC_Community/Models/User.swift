//
//  User.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import Foundation

// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let username, email: String
}

