//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-27.
//

import Foundation

public enum Authentication {
    case unauthenticated
    case authenticated(User)
}

extension Authentication: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .unauthenticated:
            break
            
        case let .authenticated(user):
            hasher.combine(user.id)
        }
    }
}

extension Authentication: Fakeable {
    public static func fake() -> Authentication {
        Authentication.authenticated(.fake())
    }
}
