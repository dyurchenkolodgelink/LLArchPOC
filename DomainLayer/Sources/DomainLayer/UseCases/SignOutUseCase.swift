//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import Combine

public protocol SignOutUseCaseProtocol {
    func execute()
}

final class SignOutUseCase: UseCase, SignOutUseCaseProtocol {
    let authenticationRepository: AuthenticationRepositoryProtocol
    let localStoreRepository: LocalStoreRepositoryProtocol
    
    init(
        authenticationRepository: AuthenticationRepositoryProtocol,
        localStoreRepository: LocalStoreRepositoryProtocol
    ) {
        self.authenticationRepository = authenticationRepository
        self.localStoreRepository = localStoreRepository
    }
    
    func execute() {
        authenticationRepository.set(authentication: .unauthenticated)
        localStoreRepository.removeValue(for: .authToken)
    }
}

public struct FakeSignOutUseCase: SignOutUseCaseProtocol {
    public init() {}
    
    public func execute() {}
}
