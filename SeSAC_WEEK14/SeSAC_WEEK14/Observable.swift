//
//  Observable.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/27.
//

import Foundation

class Observabel<T> {
    
    //3
    private var listener: ( (T) -> Void )?
    
    //2
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    //1
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}


