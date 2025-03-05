//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public protocol UseCasesFactoryProtocol {
    func makeSignInUseCase() -> SignInUseCaseProtocol
    func makeSignOutUseCase() -> SignOutUseCaseProtocol
    func makeSubscribeForAuthenticationChangesUseCase() -> SubscribeForAuthenticationChangesUseCaseProtocol
}

public struct UseCasesFactory {
    let repositoriesFactory: RepositoriesFactoryProtocol
    
    public init(
        repositoriesFactory: RepositoriesFactoryProtocol
    ) {
        self.repositoriesFactory = repositoriesFactory
    }
}

extension UseCasesFactory: UseCasesFactoryProtocol {
    public func makeSignInUseCase() -> SignInUseCaseProtocol {
        SignInUseCase(
            repository: repositoriesFactory.makeAuthenticationRepository(),
            localStorage: repositoriesFactory.makeLocalStoreRepository()
        )
    }
    
    public func makeSubscribeForAuthenticationChangesUseCase() -> SubscribeForAuthenticationChangesUseCaseProtocol {
        SubscribeForAuthenticationChangesUseCase(
            authenticationRepository: repositoriesFactory.makeAuthenticationRepository()
        )
    }
    
    public func makeSignOutUseCase() -> SignOutUseCaseProtocol {
        SignOutUseCase(
            authenticationRepository: repositoriesFactory.makeAuthenticationRepository(),
            localStoreRepository: repositoriesFactory.makeLocalStoreRepository()
        )
    }
}

public struct FakeUseCasesFactory: UseCasesFactoryProtocol {
    public func makeSignInUseCase() -> SignInUseCaseProtocol {
        FakeSignInUseCase()
    }
    
    public func makeSubscribeForAuthenticationChangesUseCase() -> SubscribeForAuthenticationChangesUseCaseProtocol {
        FakeSubscribeForAuthenticationChangesUseCase()
    }
    
    public func makeSignOutUseCase() -> SignOutUseCaseProtocol {
        FakeSignOutUseCase()
    }
}
