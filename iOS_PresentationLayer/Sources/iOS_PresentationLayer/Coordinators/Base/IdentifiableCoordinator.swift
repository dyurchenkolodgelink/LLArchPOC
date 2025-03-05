//
//  IdentifiableCoordinator.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-21.
//

import Foundation

struct IdentifiableCoordinator: Identifiable {
    let id: UUID
    let coordinator: AnyCoordinator

    init(coordinator: AnyCoordinator) {
        self.id = UUID()
        self.coordinator = coordinator
    }
}
