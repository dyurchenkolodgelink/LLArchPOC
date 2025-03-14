//
//  Email.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public struct Email: Hashable {
    public let value: String
    
    public init(_ value: String?) throws {
        guard let value
        else {
            throw CredentialsParsingError.invalidEmail
        }
        
        let regex: String = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        
        if !test.evaluate(with: value) {
            throw CredentialsParsingError.invalidEmail
        } else {
            self.value = value
        }
    }
}

extension Email: Fakeable {
    public static func fake() -> Email {
        try! Email("fakeEmail@email.com")
    }
}
