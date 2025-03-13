//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation
import Combine

public protocol SignInUseCaseProtocol {
    func execute(_ input: SignInInput) -> AnyPublisher<User, AuthenticationError>
}

final class SignInUseCase: UseCase, SignInUseCaseProtocol {
    let repository: AuthenticationRepositoryProtocol
    let localStorage: LocalStoreRepositoryProtocol
    
    init(
        repository: AuthenticationRepositoryProtocol,
        localStorage: LocalStoreRepositoryProtocol
    ) {
        self.repository = repository
        self.localStorage = localStorage
    }
    
    func execute(_ input: SignInInput) -> AnyPublisher<User, AuthenticationError> {
        preparePublisher { [unowned self] in
            do {
                let email = try Email(input.email)
                let password = try Password(input.password)
                
                localStorage.removeValue(for: .authToken)
                
                return repository.signIn(email: email, password: password)
                    .mapError { error in
                        AuthenticationError.dataError(error)
                    }
                    .tryMap { [unowned self] signInResult in
                        do {
                            try localStorage.store(signInResult.token, for: .authToken)
                            repository.set(authentication: .authenticated(signInResult.user))
                            
                            return signInResult.user
                        } catch {
                            throw AuthenticationError.dataError(.other(error))
                        }
                    }
                    .mapError { error in
                        if let error = error as? AuthenticationError {
                            return error
                        } else {
                            return AuthenticationError.dataError(.other(error))
                        }
                    }
                    .eraseToAnyPublisher()
            } catch let error as CredentialsParsingError {
                return Fail(error: AuthenticationError.credentialsParsingError(error))
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: AuthenticationError.unexpectedError(message: "Unexpected authentication error occured"))
                    .eraseToAnyPublisher()
            }
        }
    }
}

public struct FakeSignInUseCase: SignInUseCaseProtocol {
    public init() {}
    
    public func execute(_ input: SignInInput) -> AnyPublisher<User, AuthenticationError> {
        .fake()
    }
}
