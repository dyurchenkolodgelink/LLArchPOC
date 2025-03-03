//
//  Atomic.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2023-08-22.
//

import Foundation

@propertyWrapper struct Atomic<T> {
    private let queue = DispatchQueue(label: "com.lodgelink.atomic.queue")
    private var value: T
    
    var wrappedValue: T {
        get {
            queue.sync { value }
        }
        set {
            queue.sync {
                value = newValue
            }
        }
    }
    
    init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
    init(_ value: T) {
        self.value = value
    }
}
