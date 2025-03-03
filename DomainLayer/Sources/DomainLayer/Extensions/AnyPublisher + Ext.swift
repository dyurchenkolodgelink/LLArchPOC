//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation
import Combine

extension AnyPublisher: Fakeable where Output == Void, Failure == Error {
    public static func fake() -> Self {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

extension AnyPublisher where Output: Fakeable, Failure == Never, Output.T == Output {
    public static func fake() -> Self {
        Just(.fake())
            .eraseToAnyPublisher()
    }
}

extension AnyPublisher where Output: Fakeable, Failure == Error, Output.T == Output {
    public static func fake() -> Self {
        Just(.fake())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

extension AnyPublisher where Output: Fakeable, Failure: Fakeable, Output.T == Output {
    public static func fake() -> Self {
        Just(.fake())
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
}
