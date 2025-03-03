//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-03.
//

import Foundation

public protocol Fakeable {
    associatedtype T
    static func fake() -> T
}
