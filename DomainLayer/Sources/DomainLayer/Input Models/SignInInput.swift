//
//  SignInInput.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public struct SignInInput {
    public let email: String
    public let password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
}

extension SignInInput: Fakeable {
    public static func fake() -> SignInInput {
        SignInInput(email: "Asfsaf@asfsaf.com", password: "asfsafasfsaf")
    }
}
