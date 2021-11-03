//
//  RealmModel.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/11/03.
//

import Foundation
import RealmSwift

class BoxOffice: Object {
    
    @Persisted var movieTitle: String //제목(필수)
    @Persisted var relaseDate: String //개봉일(필수)
    @Persisted var registerDate = Date() //등록일 (필수)

    //PK(필수): Int, String, UUID, ObjectID 중 택 1 -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(movieTitle: String, relaseDate: String, registerDate: Date) {
        self.init()
        self.movieTitle = movieTitle
        self.relaseDate = relaseDate
        self.registerDate = registerDate
    }
}
