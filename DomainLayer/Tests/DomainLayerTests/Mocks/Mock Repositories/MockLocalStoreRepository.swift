//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import Foundation
import TestUtils
@testable import DomainLayer

final class MockLocalStoreRepository: LocalStoreRepositoryProtocol {
    var storeError: Error?
    private(set) var storedValue: AnyHashable?
    
    func store<T>(_ value: T, for key: DomainLayer.StorageKey) throws where T : Encodable & Hashable {
        if let storeError {
            throw storeError
        } else {
            storedValue = value
        }
    }
    
    func removeValue(for key: DomainLayer.StorageKey) {}
    
    func getValue<T>(for key: DomainLayer.StorageKey) throws -> T where T : Decodable {
        throw ExecutionError.withMessage("sfsfs")
    }
}
