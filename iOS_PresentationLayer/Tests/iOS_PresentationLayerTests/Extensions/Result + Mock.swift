//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-28.
//

import Foundation
import Combine

extension Result: MockedPublishable  {
    typealias O = Success
    typealias F = Failure
    
    var mockedPublisher: AnyPublisher<Success, Failure> {
        publisher.eraseToAnyPublisher()
    }
}

extension Optional where Wrapped: MockedPublishable {
    func getMockedPublisher<O, F: Error>() -> AnyPublisher<O,F> where O == Wrapped.O, F == Wrapped.F {
        self?.mockedPublisher.first().eraseToAnyPublisher()
        ?? Fail(error: MockingError.resultIsNotMocked as! F)
            .eraseToAnyPublisher()
    }
}

protocol MockedPublishable {
    associatedtype O
    associatedtype F: Error
    
    var mockedPublisher: AnyPublisher<O, F> { get }
}
