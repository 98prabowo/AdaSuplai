//
//  Observable.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 07/11/21.
//

import Foundation
import UIKit

class Observable<T> {
    var value: T? {
        didSet {
            listener.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: [((T?) -> Void)] = []
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener.append(listener)
    }
}
