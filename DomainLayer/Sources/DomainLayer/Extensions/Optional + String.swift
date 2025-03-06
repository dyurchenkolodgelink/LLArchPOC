//
//  Optional + String.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2023-05-01.
//

import Foundation

public extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        flatMap {
            $0.isEmpty
        } ?? true
    }
}
