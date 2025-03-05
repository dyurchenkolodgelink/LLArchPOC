//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation

public struct Name: Hashable {
    public let value: String
    
    public init(_ value: String?) throws {
        self.value = value ?? ""
    }
}

extension Name: Fakeable {
    public static func fake() -> Name {
        try! Name("FakeName")
    }
}
