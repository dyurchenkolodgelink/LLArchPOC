//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-28.
//

import Foundation

enum MockingError: LocalizedError {
    case resultIsNotMocked
    
    var errorDescription: String? {
        switch self {
        case .resultIsNotMocked: "Result is must be mocked"
        }
    }
}
