//
//  Observable.swift
//  AnimalManager
//
//  Created by BLU on 06/12/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
}
