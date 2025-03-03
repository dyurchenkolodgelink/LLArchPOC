//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation

public enum DataError: LocalizedError {
    case networkError(Error)
    case parsingError(Error)
    case other(Error)
    
    public var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return error.localizedDescription
        case .parsingError(let error):
            return error.localizedDescription
        case .other(let error):
            return error.localizedDescription
        }
    }
}

extension DataError: Fakeable {
    public static func fake() -> DataError {
        .other(ExecutionError.withMessage("Fake Error"))
    }
}
