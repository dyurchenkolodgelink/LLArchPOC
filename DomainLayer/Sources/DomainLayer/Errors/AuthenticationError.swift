//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public enum AuthenticationError: LocalizedError {
    case credentialsParsingError(CredentialsParsingError)
    case dataError(DataError)
    case unexpectedError(message: String)
    
    public var errorDescription: String? {
        switch self {
        case .credentialsParsingError(let credentialsParsingError):
            credentialsParsingError.localizedDescription
        case .dataError(let dataError):
            dataError.localizedDescription
        case .unexpectedError(let message):
            message
        }
    }
}

extension AuthenticationError: Fakeable {
    public static func fake() -> AuthenticationError {
        AuthenticationError.credentialsParsingError(.invalidEmail)
    }
}
