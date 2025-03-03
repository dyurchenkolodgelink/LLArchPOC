//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation

public struct SignInResult {
    public let token: AuthenticationToken
    public let user: User
    
    public init(
        token: AuthenticationToken,
        user: User
    ) {
        self.token = token
        self.user = user
    }
}

extension SignInResult: Fakeable {
    public static func fake() -> SignInResult {
        SignInResult(
            token: .fake(),
            user: .fake()
        )
    }
}
