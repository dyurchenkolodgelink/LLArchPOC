//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-05.
//

import Foundation
import Combine

public protocol GetMeUseCaseProtocol {
    func execute() -> AnyPublisher<User, DataError>
}

final class GetMeUseCase: UseCase, GetMeUseCaseProtocol {
    let userRepository: UserRepositoryProtocol
    let authenticationRepository: AuthenticationRepositoryProtocol
    
    init(
        userRepository: UserRepositoryProtocol,
        authenticationRepository: AuthenticationRepositoryProtocol
    ) {
        self.userRepository = userRepository
        self.authenticationRepository = authenticationRepository
    }
    
    func execute() -> AnyPublisher<User, DataError> {
        preparePublisher { [unowned self] in
            userRepository.getMe()
                .handleEvents(receiveOutput: { [unowned self] user in
                    authenticationRepository.set(authentication: .authenticated(user))
                })
                .eraseToAnyPublisher()
        }
    }
}

public struct FakeGetMeUseCase: GetMeUseCaseProtocol {
    public init() {}
    
    public func execute() -> AnyPublisher<User, DataError> {
        .fake()
    }
}
