//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-24.
//

import Foundation
import TestUtils
@testable import DomainLayer

func makeSignInInput(
    email: String = "mock@email.com",
    password: String = "password"
) -> SignInInput {
    
    SignInInput(email: email, password: password)
}

func makeSignInResult(
    token: AuthenticationToken = makeValidAuthenticationToken(),
    user: User = makeUser()
) -> SignInResult {
    
    SignInResult(
        token: token,
        user: user
    )
}
