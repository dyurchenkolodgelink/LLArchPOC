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
    
    init(
        authenticationRepository: AuthenticationRepositoryProtocol
    ) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute() {
        authenticationRepository.set(authentication: .unauthenticated)
    }
}

public struct FakeSignOutUseCase: SignOutUseCaseProtocol {
    public init() {}
    
    public func execute() {}
}
