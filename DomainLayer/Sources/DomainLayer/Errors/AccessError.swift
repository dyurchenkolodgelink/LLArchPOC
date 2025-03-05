//
//  AccessError.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-10-16.
//

import Foundation

public enum AccessError: LocalizedError {
    case noPermission
    
    public var errorDescription: String? {
        switch self {
        case .noPermission:
            return "No permission to access the resource."
        }
    }
}
