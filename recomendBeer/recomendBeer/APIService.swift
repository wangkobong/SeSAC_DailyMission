//
//  APIService.swift
//  recomendBeer
//
//  Created by sungyeon kim on 2021/12/21.
//

import Foundation

class APIService {
    let sourceURL = URL(string: "https://api.punkapi.com/v2/beers/random")!
    
    func requestRandomBeer(completion: @escaping (BeerElement?) -> Void){
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in

            
            print("data: \(data)")
            print("response: \(response)")
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("SERVER_ERROR")
                return
            }
            
            if let data = data, let beerData = try? JSONDecoder().decode(BeerElement.self, from: data) {
                print("SUCCEED", beerData)
                completion(beerData)
                return
            }
            print("데이터없냐?")
            completion(nil)

        }.resume()
    }
}
