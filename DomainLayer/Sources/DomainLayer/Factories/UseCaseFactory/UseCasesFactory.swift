//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public protocol UseCasesFactoryProtocol {
    func makeSignInUseCase() -> SignInUseCaseProtocol
}

public struct UseCasesFactory: UseCasesFactoryProtocol {
    let repositoriesFactory: RepositoriesFactoryProtocol
    
    public init(
        repositoriesFactory: RepositoriesFactoryProtocol
    ) {
        self.repositoriesFactory = repositoriesFactory
    }
    
    public func makeSignInUseCase() -> SignInUseCaseProtocol {
        SignInUseCase(
            repository: repositoriesFactory.makeAuthenticationRepository(),
            localStorage: repositoriesFactory.makeLocalStoreRepository()
        )
    }
}

public struct FakeUseCasesFactory: UseCasesFactoryProtocol {
    public func makeSignInUseCase() -> SignInUseCaseProtocol {
        FakeSignInUseCase()
    }
}
