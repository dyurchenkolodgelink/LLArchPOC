//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-24.
//

import Foundation
@testable import DomainLayer


func makeUser() -> User {
    User(
        id: makeID(),
        email: makeEmail(),
        firstName: makeName(),
        lastName: makeName(),
        company: nil,
        position: nil,
        phoneNumber: nil
    )
}

func makeID<T>() -> ID<T> {
    try! ID("Mocked ID")
}

func makeEmail() -> Email {
    try! Email("feafea@feefeafe.com")
}

func makePassword() -> Password {
    try! Password("123456789")
}

func makeError() -> Error {
    ExecutionError.withMessage("Custom Error")
}

func makeName() -> Name {
    try! Name("Mocked Name")
}

func makeSignInInput(
    email: String = "mock@email.com",
    password: String = "password"
) -> SignInInput {
    
    SignInInput(email: email, password: password)
}

func makeValidAuthenticationToken() -> AuthenticationToken {
    try! AuthenticationToken("SomeAuthToken")
}

func makeSignInResult() -> SignInResult {
    SignInResult(
        token: makeValidAuthenticationToken(),
        user: makeUser()
    )
}
