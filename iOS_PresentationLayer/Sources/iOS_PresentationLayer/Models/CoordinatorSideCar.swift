//
//  CoordinatorSideCar.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-10-08.
//

import Foundation
import DomainLayer

public struct CoordinatorSideCar {
//    let applicationSessionStore: ApplicationSessionStoreProtocol
    public init() {}
}

extension CoordinatorSideCar: Fakeable {
    public static func fake() -> CoordinatorSideCar {
        CoordinatorSideCar(
//            applicationSessionStore: FakeApplicationSessionStore()
        )
    }
}
