//
//  Password.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public struct Password: Hashable {
    public let value: String
    
    public init(_ value: String?) throws {
        guard let value
        else {
            throw CredentialsParsingError.invalidPassword
        }
        
        guard value.count >= 2,
              value.count <= 25
        else {
            throw CredentialsParsingError.invalidPassword
        }
        
        self.value = value
    }
}

extension Password: Fakeable {
    public static func fake() -> Password {
        try! Password("FakePassword")
    }
}
