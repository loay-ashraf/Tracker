//
//  FoundationTypes.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import Foundation

struct Observable<T> {
    
    var value: T? {
        didSet {
            listeners.forEach { $0(value) }
        }
    }
    
    private var listeners = Array<(T?) -> Void>()
    
    init() {
        self.value = nil
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    mutating func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        listeners.append(listener)
    }
    
}
