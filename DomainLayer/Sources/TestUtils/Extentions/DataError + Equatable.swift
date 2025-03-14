//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import DomainLayer

extension DataError: Equatable {
    public static func == (lhs: DataError, rhs: DataError) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
