//
//  ExecutionError.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Foundation

public enum ExecutionError: LocalizedError {
    case withMessage(String)
    
    public var errorDescription: String? {
        switch self {
        case let .withMessage(message):
            return message
        }
    }
}
