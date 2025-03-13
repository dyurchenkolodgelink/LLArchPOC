//
//  AuthenticationRepositoryProtocol.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation
import Combine

public protocol AuthenticationRepositoryProtocol {
    var authenticationPublisher: AnyPublisher<Authentication, Never> { get }
    
    func signIn(email: Email, password: Password) -> AnyPublisher<SignInResult, DataError>
    func set(authentication: Authentication)
    func getAuthentication() -> AnyPublisher<Authentication, Never>
}

public struct FakeAuthenticationRepository: AuthenticationRepositoryProtocol {
    public let authenticationPublisher: AnyPublisher<Authentication, Never> = .fake()
    
    public init() {}
    
    public func set(authentication: Authentication) {}
    public func getAuthentication() -> AnyPublisher<Authentication, Never> { .fake() }
    public func signIn(email: Email, password: Password) -> AnyPublisher<SignInResult, DataError> { .fake() }
}
