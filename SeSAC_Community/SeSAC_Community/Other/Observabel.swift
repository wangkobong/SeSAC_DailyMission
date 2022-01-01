//
//  Observabel.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import Foundation

class Observabel<T> {
    
    private var listener: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
