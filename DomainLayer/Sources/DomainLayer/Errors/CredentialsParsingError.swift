//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-24.
//

import Foundation

public enum CredentialsParsingError: LocalizedError {
    case invalidEmail
    case invalidPassword
    
    public var errorDescription: String? {
        switch self {
        case .invalidEmail:
            "Invalid email format"
            
        case .invalidPassword:
            "The password should be between 2 and 25 characters long"
        }
    }
}
