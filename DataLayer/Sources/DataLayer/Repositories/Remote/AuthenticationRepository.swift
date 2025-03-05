//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation
import DomainLayer
import Combine

final class AuthenticationRepository: GraphQLRepository, AuthenticationRepositoryProtocol {
    @Atomic var authentication: Authentication = .unauthenticated
    
    private let authenticationSubject = PassthroughSubject<Authentication, Never>()
    
    var authenticationPublisher: AnyPublisher<Authentication, Never> {
        authenticationSubject.eraseToAnyPublisher()
    }
    
    func set(authentication: Authentication) {
        self.authentication = authentication
        
        authenticationSubject.send(authentication)
    }
    
    func getAuthentication() -> AnyPublisher<Authentication, Never> {
        Just(authentication)
            .eraseToAnyPublisher()
    }
    
    func signIn(email: Email, password: Password) -> AnyPublisher<DomainLayer.SignInResult, DomainLayer.DataError> {
        let mutation = LoginMutation(emailAddress: email.value, password: password.value)
        
        return execute(mutation: mutation) { [unowned self] response, extractOutput in
            let loginResponse = try extractOutput(response.data?.login)
            let userResponse = try unwrap(response: loginResponse.me)
            let authToken = try AuthenticationToken(loginResponse.accountToken)
            let user = try userResponse.toDomain()
            
            return SignInResult(
                token: authToken,
                user: user
            )
        }
    }
}
