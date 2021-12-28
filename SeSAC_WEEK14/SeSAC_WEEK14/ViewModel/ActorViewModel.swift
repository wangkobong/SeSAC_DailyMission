//
//  ActorViewModel.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/28.
//

import Foundation

class ActorViewModel {
    
    var actor: Observabel<Actor> = Observabel(Actor(page: 0, results: [], totalPages: 0, totalResults: 0))
    
    func fetchActor(query: String, page: Int) {
        APIService.person(query, page: page) { response, error in
            guard let response = response else {
                return
            }
            
            self.actor.value = response
          
        }
    }
}

extension ActorViewModel {
    
    var numberOfRowInSection: Int {
        return actor.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return actor.value.results[indexPath.row]
    }
}
