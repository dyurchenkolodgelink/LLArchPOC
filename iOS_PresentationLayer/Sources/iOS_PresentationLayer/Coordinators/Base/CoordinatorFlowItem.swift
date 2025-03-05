//
//  CoordinatorFlowItem.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-21.
//

import Foundation
import  DomainLayer

public protocol CoordinatorFlowItem: Identifiable, Hashable {
    var viewModel: any ViewModel { get }
}

public extension CoordinatorFlowItem {
    var id: UUID { viewModel.id }
    var requiredPermissions: Set<OrgPermission> { viewModel.requiredPermissions }
}
