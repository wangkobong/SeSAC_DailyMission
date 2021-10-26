//
//  TrendMedia++Bundle.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/26.
//

import Foundation

extension Bundle {
    var clientID: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else{ return "" }
        
        guard let resouce = NSDictionary(contentsOfFile: file) else { return ""}
        guard let clientID = resouce["X-Naver-Client-Id"] as? String else { fatalError("WeatherInfo.plist에 clientID설정을 해주세요.")}
        return clientID
    }
    
    var clientSecret: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else{ return "" }
        
        guard let resouce = NSDictionary(contentsOfFile: file) else { return ""}
        guard let clientSecret = resouce["X-Naver-Client-Secret"] as? String else { fatalError("WeatherInfo.plist에 clientID설정을 해주세요.")}
        return clientSecret
    }
    
    var boxOfficeKey: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else{ return "" }
        
        guard let resouce = NSDictionary(contentsOfFile: file) else { return ""}
        guard let boxOfficeKey = resouce["BoxOfficeKey"] as? String else { fatalError("WeatherInfo.plist에 BoxOfficeKey설정을 해주세요.")}
        return boxOfficeKey
    }
}


