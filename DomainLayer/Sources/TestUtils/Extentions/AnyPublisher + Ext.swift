//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-24.
//

import Foundation
import Combine
import XCTest

public extension Publisher {
    @discardableResult func async(
        after block: (() -> Void)? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> Output {
        
        block?()
        let output = try await eraseToAnyPublisher().values.first()
        
        return try XCTUnwrap(output, "Couldn't unwrap output", file: file, line: line)
    }
}

public extension AsyncSequence {
    func first() async rethrows -> Element? {
        try await first(where: { _ in true})
    }
}
