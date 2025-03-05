//
//  CoordinatorSideCar.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-10-08.
//

import Foundation
import DomainLayer

struct CoordinatorSideCar {
//    let applicationSessionStore: ApplicationSessionStoreProtocol
}

extension CoordinatorSideCar: Fakeable {
    static func fake() -> CoordinatorSideCar {
        CoordinatorSideCar(
//            applicationSessionStore: FakeApplicationSessionStore()
        )
    }
}
