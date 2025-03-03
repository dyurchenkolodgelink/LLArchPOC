//
//  ID.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-10-08.
//

import Foundation

public struct ID<T>: Hashable, Equatable {
    public let value: String
    
    public init(_ value: String?) throws {
        guard let value, !value.isEmpty
        else { throw IdentificationError.emptyIdentifier(forType: String(describing: type(of: self))) }
        
        self.value = value
    }
}

extension ID: Fakeable {
    public static func fake() -> ID<T> {
        try! ID("Fake ID \(Int.random(in: 0...1000))")
    }
}
