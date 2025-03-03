//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation

public enum IdentificationError: LocalizedError {
    case emptyIdentifier(forType: String)
}

extension IdentificationError: Fakeable {
    public static func fake() -> IdentificationError {
        IdentificationError.emptyIdentifier(forType: "Fake Type")
    }
}
