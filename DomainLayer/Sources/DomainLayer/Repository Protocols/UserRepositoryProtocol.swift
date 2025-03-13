//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-05.
//

import Foundation
import Combine

public protocol UserRepositoryProtocol {
    func getMe() -> AnyPublisher<User, DataError>
}

public struct FakeUserRepository: UserRepositoryProtocol {
    public init() {}
    
    public func getMe() -> AnyPublisher<User, DataError> {
        .fake()
    }
}
