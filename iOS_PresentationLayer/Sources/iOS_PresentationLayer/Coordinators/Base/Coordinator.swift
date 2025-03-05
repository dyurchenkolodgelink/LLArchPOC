//
//  Coordinator.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-21.
//

import Foundation

protocol Coordinator: AnyCoordinator {
    associatedtype FlowElement: CoordinatorFlowItem
    
    var initialFlowElement: FlowElement { get }
    var path: [FlowElement] { get }
    var presentedItem: FlowElement? { get }
}

extension Coordinator {
    var anyPath: [any CoordinatorFlowItem] { path as [any CoordinatorFlowItem] }
}
