//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-24.
//

import Foundation
import DomainLayer

public func makeUser() -> User {
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

public func makeID<T>() -> ID<T> {
    try! ID("Mocked ID")
}

public func makeEmail() -> Email {
    try! Email("feafea@feefeafe.com")
}

public func makePassword() -> Password {
    try! Password("123456789")
}

public func makeError() -> Error {
    ExecutionError.withMessage("Custom Error")
}

public func makeName() -> Name {
    try! Name("Mocked Name")
}

public func makeValidAuthenticationToken() -> AuthenticationToken {
    try! AuthenticationToken("SomeAuthToken")
}
