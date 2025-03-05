//
//  LocalStoreRepositoryProtocol.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-11-18.
//

import Foundation

public protocol LocalStoreRepositoryProtocol {
    func store<T>(_ value: T, for key: StorageKey) throws where T: Encodable
    func removeValue(for key: StorageKey)
    func getValue<T>(for key: StorageKey) throws -> T where T: Decodable
}

public struct FakeLocalStoreRepository: LocalStoreRepositoryProtocol {
    public init() {}
    
    public func store<T>(_ value: T, for key: StorageKey) throws where T: Encodable {}
    public func getValue<T>(for key: StorageKey) throws -> T where T: Decodable {
        throw ExecutionError.withMessage("Fake Error Message")
    }
    public func removeValue(for key: StorageKey) {}
}
