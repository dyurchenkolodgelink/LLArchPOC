//
//  AnyCoordinator.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-21.
//

import SwiftUI
import DomainLayer

protocol AnyCoordinator {
    var anyPath: [any CoordinatorFlowItem] { get }
    
    @ViewBuilder func makeRouterView() -> AnyView
    
    func tryToMakeRouterView(permissions: Set<OrgPermission>) throws -> AnyView
}
