//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import Combine

public protocol SubscribeForAuthenticationChangesUseCaseProtocol {
    func execute() -> AnyPublisher<Authentication, Never>
}

final class SubscribeForAuthenticationChangesUseCase: UseCase, SubscribeForAuthenticationChangesUseCaseProtocol {
    let authenticationRepository: AuthenticationRepositoryProtocol
    
    init(
        authenticationRepository: AuthenticationRepositoryProtocol
    ) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute() -> AnyPublisher<Authentication, Never> {
        preparePublisher { [unowned self] in
            authenticationRepository.authenticationPublisher
        }
    }
}

public final class FakeSubscribeForAuthenticationChangesUseCase: SubscribeForAuthenticationChangesUseCaseProtocol {
    public init() {}
    
    public func execute() -> AnyPublisher<Authentication, Never> {
        .fake()
    }
}
