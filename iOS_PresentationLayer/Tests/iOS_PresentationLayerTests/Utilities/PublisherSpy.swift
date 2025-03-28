//
//  PublisherSpy.swift
//  LodgeLinkTests
//
//  Created by Dmytro Yurchenko on 2023-04-28.
//

import Foundation
import Combine

final class PublisherSpy<Output, Failure: Error> {
    private var cancellable: AnyCancellable?
    private(set) var values: [Output] = []
    private(set) var errors: [Failure] = []
    
    init(
        publisher: AnyPublisher<Output, Failure>,
        completeOn value: Output? = nil,
        onComplete: @escaping () -> Void = {}
    ) {
        cancellable = publisher.sink(receiveCompletion: { [unowned self] in
            switch $0 {
            case let .failure(error):
                errors.append(error)
                
            case .finished:
                break
            }
            
            onComplete()
        }, receiveValue: { [unowned self] in
            values.append($0)
            
            if let value = value, values.contains(where: { $0 as AnyObject === value as AnyObject }) {
                onComplete()
            }
        })
    }
}

extension Publisher {
    func makeSpy() -> PublisherSpy<Output, Failure> {
        PublisherSpy(publisher: eraseToAnyPublisher())
    }
}
