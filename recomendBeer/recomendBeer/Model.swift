//
//  Model.swift
//  recomendBeer
//
//  Created by sungyeon kim on 2021/12/21.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    
    
    
    let name, tagline, firstBrewed, welcomeDescription: String
    let imageURL: String
    let brewersTips: String

    enum CodingKeys: String, CodingKey {
        case name, tagline
        case firstBrewed = "first_brewed"
        case welcomeDescription = "description"
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        tagline = try container.decode(String.self, forKey: .tagline)
        firstBrewed = try container.decode(String.self, forKey: .firstBrewed)
        welcomeDescription = try container.decode(String.self, forKey: .welcomeDescription)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        brewersTips = try container.decode(String.self, forKey: .brewersTips)
    }
}
