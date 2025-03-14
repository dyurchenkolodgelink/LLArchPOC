//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import Foundation
import Combine
@testable import DomainLayer

final class MockAuthenticationRepository: AuthenticationRepositoryProtocol {
    var authenticationPublisher: AnyPublisher<DomainLayer.Authentication, Never> = Just(.unauthenticated).eraseToAnyPublisher()
    var signInResult: Result<SignInResult, DataError> = .success(makeSignInResult())
    
    private(set) var isSignInInvoked = false
    
    func signIn(email: Email, password: Password) -> AnyPublisher<SignInResult, DataError> {
        isSignInInvoked = true
        
        return signInResult.publisher.eraseToAnyPublisher()
    }
    
    func set(authentication: DomainLayer.Authentication) {
        
    }
    
    func getAuthentication() -> AnyPublisher<DomainLayer.Authentication, Never> {
        authenticationPublisher
    }
}
