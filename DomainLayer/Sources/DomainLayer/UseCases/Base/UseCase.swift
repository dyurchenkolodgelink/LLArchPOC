//
//  UseCase.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation
import Combine

class UseCase {
    let workingQueue: DispatchQueue
    var cancellableSet: Set<AnyCancellable> = []

    init() {
        let queueLabel = "com.lodgelink.\(String(describing: type(of: self)))"
        workingQueue = DispatchQueue(label: queueLabel)
    }
    
    final func preparePublisher<O,E>(_ publisher: @escaping () -> AnyPublisher<O, E>) -> AnyPublisher<O, E> where E: Error {
        Deferred {
            publisher()
        }
        .subscribe(on: workingQueue)
        .eraseToAnyPublisher()
    }
}
