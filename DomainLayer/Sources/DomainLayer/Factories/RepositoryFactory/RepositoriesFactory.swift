//
//  RepositoriesFactory.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public protocol RepositoriesFactoryProtocol {
    func makeAuthenticationRepository() -> AuthenticationRepositoryProtocol
    func makeLocalStoreRepository() -> LocalStoreRepositoryProtocol
    func makeUserRepository() -> UserRepositoryProtocol
}

public struct FakeRepositoriesFactoryProtocol: RepositoriesFactoryProtocol {
    public func makeAuthenticationRepository() -> AuthenticationRepositoryProtocol {
        FakeAuthenticationRepository()
    }
    
    public func makeLocalStoreRepository() -> LocalStoreRepositoryProtocol {
        FakeLocalStoreRepository()
    }
    
    public func makeUserRepository() -> UserRepositoryProtocol {
        FakeUserRepository()
    }
}
