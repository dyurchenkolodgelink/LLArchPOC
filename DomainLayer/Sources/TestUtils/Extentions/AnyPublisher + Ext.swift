//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-24.
//

import Foundation
import Combine

public extension AnyPublisher {
    func async() async throws -> Output? {
        try await eraseToAnyPublisher().values.first()
    }
}

public extension AsyncSequence {
    func first() async rethrows -> Element? {
        try await first(where: { _ in true})
    }
}
