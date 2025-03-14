//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation

public struct AuthenticationToken: Codable, Hashable {
    public let value: String
    
    public init(_ value: String?) throws {
        guard let value
        else {
            throw AuthenticationError.dataError(.parsingError(ExecutionError.withMessage("Auth token is empty")))
        }
        
        self.value = value
    }
}

extension AuthenticationToken: Fakeable {
    public static func fake() -> AuthenticationToken {
        try! AuthenticationToken("FakeToken")
    }
}
