//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation

public enum Authentication: Hashable {
    case unauthenticated
    case authenticated(User)
}

extension Authentication: Fakeable {
    public static func fake() -> Authentication {
        Authentication.authenticated(.fake())
    }
}
