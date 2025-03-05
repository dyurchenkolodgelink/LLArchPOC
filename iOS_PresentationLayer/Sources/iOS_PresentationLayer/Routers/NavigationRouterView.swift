//
//  NavigationRouterView.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-22.
//

import SwiftUI

struct NavigationRouterView<Coordinator, Item>: View where Item: CoordinatorFlowItem, Coordinator: BaseCoordinator<Item> {
    @ObservedObject var coordinator: Coordinator
    
    @Binding var shouldBeDismissed: Bool
    
    var body: some View {
        NavigationStack(path: coordinator.pathBinding) {
            coordinator.getNextFlowItemView(for: coordinator.initialFlowElement)
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(
                    for: Item.self,
                    destination: { item in
                        coordinator.getNextFlowItemView(for: item)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                )
        }
        .tint(.white)
//        .dismissSheet(on: $shouldBeDismissed)
        .sheet(
            item: coordinator.presentedItemBinding,
            onDismiss: {},
            content: { item in
                coordinator.getNextFlowItemView(for: item)
            }
        )
//        .fittedSheet(
//            item: coordinator.bottomSheetItemBinding,
//            content: { item in
//                coordinator.getNextFlowItemView(for: item)
//            }
//        )
//        .blurredPopover(item: coordinator.popoverItemBinding) { item, onDismiss in
//            coordinator.getNextFlowItemView(for: item)
//        }
    }
}
